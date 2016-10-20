//
//  UserMoreInformationTableViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/26.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import QueryKit
import SwiftyJSON

class UserMoreInformationTableViewController: UITableViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var loglabel: UILabel!
    
    @IBOutlet weak var usersign: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userphone: UILabel!
    @IBOutlet weak var useremail: UILabel!
    @IBOutlet weak var userlocation: UILabel!
    @IBOutlet weak var userphoto: UIImageView!
    
    var user: User!
    
    let context = dataStack.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loglabel.text = "注销"
        
        usersign.text = user.signature
        username.text = user.name
        userphone.text = user.loginname
        userlocation.text = user.location
        useremail.text = user.email
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        defaults.set(nil, forKey: "uesrname")
        defaults.synchronize()
        //TODO 删除 CoreData 中的 User 表中的数据
        let querySort = QuerySet<User>(context, User.entityName)
        let _ = try! querySort.delete()
        try! context.save()
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
            //修改个人简介
            let vc = storyboard?.instantiateViewController(withIdentifier: "changejianjie") as! ChangeJianJieViewController
            vc.user = user
            self.navigationController?.pushViewController(vc, animated: true)
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
            changeValue(title: "昵称", rawValue: user.name,index: 2)
        case 3:
            //修改地区
            changeValue(title: "地区", rawValue: user.location,index: 3)
        case 4:
            //修改个性签名
            changeValue(title: "个性签名", rawValue: user.signature,index: 4)
        default:
            break
        }
    }
    
    func changeValue(title: String,rawValue: String,index: Int) {
        let alter = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alter.addTextField { (textfeild) in
            textfeild.placeholder = rawValue
        }
        alter.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alter.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            let textfeild = alter.textFields?.first!
            let value = textfeild?.text
            guard let newvalue = value else {
                return
            }
            
            guard !newvalue.isEmpty else {
                return
            }
            
            switch index {
            case 2:
                UserRouterMoyaProvider.request(UserRouterMoya.changeName(id: self.user.id, newName: newvalue), completion: { (result) in
                    switch result {
                    case .success(let response):
                        let json = JSON(data: response.data)
                        if json["success"].boolValue {
                            self.user.name = newvalue
                            self.username.text = newvalue
                        }else {
                         fallthrough
                        }
                    case .failure(_): break
                        
                    }
                })
            case 3:
                
                UserRouterMoyaProvider.request(UserRouterMoya.changeLocation(id: self.user.id, location: newvalue), completion: { (result) in
                    switch result {
                    case .success(let response):
                        let json = JSON(data: response.data)
                        if json["success"].boolValue {
                            self.user.location = newvalue
                            self.userlocation.text = newvalue
                        }else {
                            fallthrough
                        }
                    case .failure:
                        break
                    }
                })
            case 4:
                UserRouterMoyaProvider.request(UserRouterMoya.changeSignature(id: self.user.id, signature: newvalue), completion: { (result) in
                    switch result {
                    case .success(let response):
                        let json = JSON(data: response.data)
                        if json["success"].boolValue {
                            self.user.signature = newvalue
                            self.usersign.text = newvalue
                        }else {
                            fallthrough
                        }
                    case .failure:
                        break
                    }
                })
            default:
                break
            }

        }))
        self.present(alter, animated: true, completion: nil)
    }
    
}
