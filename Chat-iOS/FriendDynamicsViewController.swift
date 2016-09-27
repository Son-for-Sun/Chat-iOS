//
//  FriendDynamicsViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import CoreData
import MJRefresh
import SwiftyJSON
import RxSwift
import Kingfisher
///好友动态，网络获取本地缓存.
class FriendDynamicsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<DynamicsCache>(entityName: DynamicsCache.entityName)
    let disposeBag = DisposeBag()
    var dynamics = [DynamicsModel]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        tableView.mj_header.beginRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toinsforfdk":
            let vc = segue.destination as! DynamicsValueInformationViewController
            let index = tableView.indexPathForSelectedRow!
            let dyn = dynamics[index.row]
            vc.dynamic = dyn
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
        request.includesPropertyValues = true
        request.returnsObjectsAsFaults = false
        let data = try! context.fetch(request).first
        
        guard let isdata = data else {
            ///如果没有数据那么则直接获取数据
            fetchDataFormNet()
            return
        }
        ///如果存在缓存，则先删除缓存然后再获取新的数据
        context.delete(isdata)
        try! context.save()
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
                let getResponseObject = try response.filterSuccessfulStatusAndRedirectCodes().mapArray(DynamicsModel.self)
                self.dynamics = getResponseObject
                //向CoreData 中缓存数据
                let cachedes = NSEntityDescription.entity(forEntityName: DynamicsCache.entityName, in: self.context)!
                let ccache = DynamicsCache(entity: cachedes, insertInto: self.context)
                ccache.cacheData = response.data
                try! self.context.save()
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
        request.includesPropertyValues = true
        request.returnsObjectsAsFaults = false
        let data = try! context.fetch(request).first
        let objectArray = data?.cacheData.mapObjectsArray(type: DynamicsModel.self)
        
        guard let resarray = objectArray else {
            fetchDataFormNet()
            return
        }
        self.dynamics = resarray
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
