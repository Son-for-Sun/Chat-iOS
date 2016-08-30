//
//  UserMoreInformationTableViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/26.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class UserMoreInformationTableViewController: UITableViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var loglabel: UILabel!
    
    @IBOutlet weak var usersign: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userphone: UILabel!
    @IBOutlet weak var useremail: UILabel!
    @IBOutlet weak var userlocation: UILabel!
    @IBOutlet weak var userphoto: UIImageView!
    
    var user: UserModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loglabel.text = "注销"

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let userData = defaults.value(forKey: "userdata") as? Data
        user = UserModel(fromData: userData)
        usersign.text = user.signature
        username.text = user.name
        userphone.text = user.loginname
        userlocation.text = user.location
        useremail.text = user.email
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 3
        default:
            return 1
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            sectionOne(indxPath: indexPath)
        case 1:
            sectionTwo(indxPath: indexPath)
        default:
            sectionThree(indxPath: indexPath)
        }
    }
    
    //第三个 Section的每个 cell 的操作
    func sectionThree(indxPath:IndexPath) {
        
        defaults.set(false, forKey: "isLogin")
        defaults.synchronize()
        self.navigationController!.popToRootViewController(animated: true)

    }
    //第二个 Section 的每个 cell 的操作
    func sectionTwo(indxPath:IndexPath) {
        switch indxPath.row {
        case 0:
            // 电话号码的显示
            break
        case 1:
            //邮箱的显示
            break
        default:
            break
        }
    }
    //第一个Section 的 每个 cell 的操作
    func sectionOne(indxPath:IndexPath) {
        switch indxPath.row {
        case 0:
            //更换头像
            break
        case 1:
            //更换背景图
            break
        case 2:
            //修改昵称
            break
        case 3:
            //修改地区
            break
        case 4:
            //修改个性签名
            break
        default:
            break
        }
    }
}
