//
//  FriendDynamicsViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import MJRefresh
class FriendDynamicsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    @IBAction func momentsToAboutMe(_ sender: UIBarButtonItem) {
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "isLogin") {
            let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "about") as! AboutMeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setUpTableView() {
        
    }
}

extension FriendDynamicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MomentsCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
