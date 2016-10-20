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
import Kingfisher
import Haneke
import PromiseKit
///好友动态，网络获取本地缓存.
class FriendDynamicsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dynamics = [DynamicsModel]()
    
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
    func tabled(array: [DynamicsModel]) -> Promise<Void> {
        return Promise{ fulfill, reject in
            self.dynamics = array.sorted{$0.0.pushdate > $0.1.pushdate}
            fulfill()
        }
    }
    /// 从网络中获取数据
    func fetchDataFormNet() {
        _ = friendDynamicProvider
            .request(FriendDynamics.show(pushdate: "dd"))
            .then{ Shared.dataCache.set(data: $0.data, key: "FriendDynamics")}
            .then{ $0.mapObjectsArray(type: DynamicsModel.self) }
            .then{ self.tabled(array: $0) }
            .always {
                self.tableView.mj_header.endRefreshing()
                self.tableView.reloadData()
            }
    }
    
    /// 从缓存中获数据
    ///
    /// - returns: 返回缓存中的数据可能是空值
        func fetchDataFromCoreData(){
            _ = cache
                .fetch("FriendDynamics")
                .recover(execute: { (_) -> Promise<Data> in
                    return friendDynamicProvider
                        .request(FriendDynamics.show(pushdate: ""))
                        .then{ Shared.dataCache.set(data: $0.data, key: "FriendDynamics")}
                })
                .then{ $0.mapObjectsArray(type: DynamicsModel.self) }
                .then{ self.tabled(array: $0)}
                .always { self.tableView.reloadData()}
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
