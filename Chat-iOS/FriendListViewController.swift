//
//  FriendListViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import MJRefresh

///TODO 好友列表，网络获取本地缓存。
class FriendListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
   
    var friends = [Friend]()
    var friendslist = [FriendsList]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    override func viewWillAppear(_ animated: Bool) {
        
        _ = friendsRouterProvider.request(FriendsRouter.allFriend(userphonenumber: defaults.string(forKey: UserDefaultsKeys.userName.rawValue) ?? ""))
            .then{$0.mapObjectArrayPromise(type: FriendsList.self)}
            .then{self.friendslist = $0 }
            .always {
                self.friends = []
                self.friendslist.forEach{
                    _ = UserRouterMoyaProvider.request(UserRouterMoya.showUser(name: $0.name))
                        .then{ $0.mapObjectPromise(type: Friend.self) }
                        .then{ self.friends.append($0)}
                        .always {
                        self.tableView.reloadData()
                    }
                }
                
            }
    }
    @IBAction func friendToAbout(_ sender: AnyObject) {
        
        if !defaults.bool(forKey: UserDefaultsKeys.isLogin.rawValue) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "about") as! AboutMeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }



}





//MARK: UITableViewDataSource
extension FriendListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return friends.count

    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell", for: indexPath) as! FriendListTableViewCell
        
        let friend = friends[indexPath.row]
        cell.setupCell(userPhotoURL: friend.avatar, userName: friend.name)
        return cell
    }

}
