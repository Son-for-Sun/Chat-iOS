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
import DZNEmptyDataSet
import AttributedLib
///好友动态，网络获取本地缓存.
class FriendDynamicsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
  var dynamics = [DynamicsModel]() {
    didSet {
      self.tableView.reloadData()
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toinsforfdk":

            let vc = segue.destination as! DynamicsValueInformationViewController
            let index = tableView.indexPathForSelectedRow!
            let dyn = dynamics[index.row]
          
        case "newmoments":
            let vc = segue.destination as! PushNewFriendDynamicsViewController
            vc.delegate = self
        default:
            break
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
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        fetchDataFromCoreData()
    }
    
    
    /// 当没有数据时作出的错误提示
    func noDataNoties() {
        print("发生了错误")
    }

    /// 从网络中获取数据
    func fetchDataFormNet() {
      friendDynamicProvider.request(FriendDynamics.show) { (result) in
        switch result {
        case .failure(let error):
          print(error.localizedDescription)
        case .success(let response):
          let pots = response.data.mapObjectsArray(type: DynamicsModel.self)
          self.dynamics = pots ?? []
        }
      }
    }
  
    /// 从缓存中获数据
    ///
    /// - returns: 返回缓存中的数据可能是空值
    func fetchDataFromCoreData(){
      fetchDataFormNet()
    }
}

extension FriendDynamicsViewController: DZNEmptyDataSetSource {
  func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
    return "你没有任何的动态".attributed{
      $0.font(UIFont.boldSystemFont(ofSize: 18.0))
      .foreground(color: UIColor.darkGray)
    }
  }
}

extension FriendDynamicsViewController: DZNEmptyDataSetDelegate {
  
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
        cell.username.text = value.user.name
        cell.pushvalue.text = value.pushvalue
//        cell.userimage.kf.setImage(with: value.userava, placeholder: Image(named: "Mummy Filled"))
        return cell
    }
}

extension FriendDynamicsViewController: PushNewFriendDynamicsDelegate {
    func didPushNewFriendDynamics() {
        self.tableView.mj_header.beginRefreshing()
    }
}
