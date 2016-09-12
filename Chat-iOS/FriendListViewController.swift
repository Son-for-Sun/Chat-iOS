//
//  FriendListViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import MJRefresh
class FriendListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var friends = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func friendToAbout(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: UserDefaultsKeys.isLogin.rawValue) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "about") as! AboutMeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


}

extension FriendListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell", for: indexPath) as! FriendListTableViewCell
        cell.setupCell(userPhotoURL: friends[indexPath.row].avatar, userName: friends[indexPath.row].name)
        return cell
    }
}
