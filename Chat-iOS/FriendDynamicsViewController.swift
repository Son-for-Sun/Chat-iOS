//
//  FriendDynamicsViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON
import RxSwift
import Kingfisher
import Haneke
///好友动态，网络获取本地缓存.
class FriendDynamicsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    

    let disposeBag = DisposeBag()
    var dynamics = [DynamicsModel]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    let cache = Shared.dataCache
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toinsforfdk":
            let vc = segue.destination as! DynamicsValueInformationViewController
            let index = tableView.indexPathForSelectedRow!
            let dyn = dynamics[index.row]
            vc.dynamic = dyn
        case "newmoments":
            let vc = segue.destination as! PushNewFriendDynamicsViewController
            vc.delegate = self
        default:
            break
        }
    }
    
    
    /// 点击左上角的按钮跳转关于我的主页
    ///
    /// - parameter sender: button
    @IBAction func momentsToAboutMe(_ sender: UIBarButtonItem) {
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: UserDefaultsKeys.isLogin.rawValue) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "about") as! AboutMeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    /// 下拉刷新时从网络获取数据
    func pullDownFetchData() {
        fetchDataFormNet()
    }
    
    /// 初始化 tableview
    func setUpTableView() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pullDownFetchData))
        tableView.mj_header = header
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        fetchDataFromCoreData()
    }
    
    
    /// 当没有数据时作出的错误提示
    func noDataNoties() {
        print("发生了错误")
    }
    
    /// 从网络中获取数据
    func fetchDataFormNet() {

        friendDynamicRXprovider.request(FriendDynamics.show(pushdate: "")).subscribe(onNext: { (response) in
            do {
                let getResponseObject = try response.filterSuccessfulStatusAndRedirectCodes().mapArray(DynamicsModel.self).sorted(by: { (one, two) -> Bool in
                    return one.pushdate > two.pushdate
                })
                self.dynamics = getResponseObject
                //缓存数据
                self.cache.set(value: response.data, key: "FriendDynamicsViewController")
                self.tableView.mj_header.endRefreshing()
            }catch {
                self.noDataNoties()
                self.tableView.mj_header.endRefreshing()
            }
            }, onError: { (error) in
                self.noDataNoties()
                self.tableView.mj_header.endRefreshing()
            }).addDisposableTo(disposeBag)

    }
    
    /// 从缓存中获数据
    ///
    /// - returns: 返回缓存中的数据可能是空值
        func fetchDataFromCoreData(){
        
        cache.fetch(key: "FriendDynamicsViewController").onSuccess {(data) in
            
                let objectArray = data.mapObjectsArray(type: DynamicsModel.self)?.sorted(by: { (one, two) -> Bool in
                    
                    return one.pushdate > two.pushdate
                })
                
                guard let resarray = objectArray else {
                    self.fetchDataFormNet()
                    return
                }
                self.dynamics = resarray
            }.onFailure { _ in
             self.fetchDataFormNet()
        }
    }
}

extension FriendDynamicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dynamics.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MomentsCell", for: indexPath) as! FriendDynamicsTableViewCell
        let value = dynamics[indexPath.row]
        cell.username.text = value.userName
        cell.pushvalue.text = value.pushvalue
        cell.userimage.kf.setImage(with: value.userava, placeholder: Image(named: "Mummy Filled"))
        return cell
    }
}

extension FriendDynamicsViewController: PushNewFriendDynamicsDelegate {
    func didPushNewFriendDynamics() {
        self.tableView.mj_header.beginRefreshing()
    }
}
