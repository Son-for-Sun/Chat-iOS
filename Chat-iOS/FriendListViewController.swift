//
//  FriendListViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import MJRefresh
import DZNEmptyDataSet
import AttributedLib
///TODO 好友列表，网络获取本地缓存。
class FriendListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
   
  var friends = [User]() {
    didSet{
      tableView.reloadData()
    }
  }
    var friendslist = [FriendsList]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        let user = User.fetchCurrentUser()!
        UserRouterMoyaProvider.request(UserRouterMoya.fetchFriiend(id: user.id)) { (result) in
          switch result {
          case .failure(_):
            break
          case .success(let response):
            
            let list = response.data.mapObjectsArray(type: FriendsList.self)
            self.friendslist = list ?? []
            self.friendslist.forEach({ (friend) in
                UserRouterMoyaProvider.request(UserRouterMoya.showUser(name: friend.name), completion: { (result) in
                  let data = result.value!.data
                  let user = data.mapObject(type: User.self)
                  self.friends.append(user!)
                })
            })
          }
      }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {
            return
        }
        switch id {
        case "gofriendinformation":
            let vc = segue.destination as! FriendInformationViewController
            let index = tableView.indexPathForSelectedRow!
            vc.friend = friends[index.row]
        default:
            break
        }
    }
}



extension FriendListViewController: DZNEmptyDataSetSource {
  func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
    return "你还没有任何的好友".attributed{
      $0.font(UIFont.boldSystemFont(ofSize: 18.0))
      .foreground(color: UIColor.darkGray)
    }
  }
  
  func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
    return "赶快去添加好友，一起来聊天吧".attributed{
      $0.font(UIFont.systemFont(ofSize: 15.0))
      .foreground(color: UIColor.darkGray)
    }
  }
  
  func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
    return .white
  }
  
}

extension FriendListViewController: DZNEmptyDataSetDelegate {
  
}
//MARK: UITableViewDataSource
extension FriendListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return friends.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell", for: indexPath) as! FriendListTableViewCell
        
        let friend = friends[indexPath.row]
        cell.setupCell(userPhotoURL: friend.avatar, userName: friend.name)
        return cell
    }

}
