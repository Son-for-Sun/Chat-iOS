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

/*
 let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
 let requst = NSFetchRequest<User>(entityName: User.entityName)
 
 let users = try! context.fetch(requst)
 if !users.isEmpty {
 let user = users.first!
 
 RequestAPI.share.exeRequest(router: FriendDynamics.add(userid: user.id, userName: user.name, userava: user.avatar, vaslue: "杨晓磊正在发朋友圈你好吗", pushdate: Date().description), completionHandler: { (data) in
 let jsondata = JSON(data: data.data!)
 print(jsondata["success"].bool)
 })
 }
 */

///好友动态，网络获取本地缓存.
class FriendDynamicsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<DynamicsCache>(entityName: DynamicsCache.entityName)
    
    var dynamics = [DynamicsModel]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
 
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
    
    func setUpTableView() {
        
        if let data = fetchDataFromCoreData() {
            let res = paseDataToJSON(data: data.cacheData)
            guard let resarray = res else {
                noDataNoties()
                return
            }
            dynamics = resarray
        }else{
            //缓存中没有数据从网络获取
            fetchDataFormNet()
        }
    }
    
    
    func noDataNoties() {
        print("发生了错误")
    }
    func fetchDataFormNet() {
        RequestAPI.share.exeRequest(router: FriendDynamics.show(pushdate: Date().description)) { (response) in
            
            guard let data = response.data , let resarray = self.paseDataToJSON(data: data) else {
                self.noDataNoties()
                return
            }
            
            self.dynamics = resarray
            //向CoreData 中缓存数据
            let cachedes = NSEntityDescription.entity(forEntityName: DynamicsCache.entityName, in: self.context)!
            let ccache = DynamicsCache(entity: cachedes, insertInto: self.context)
            ccache.cacheData = data
            try! self.context.save()
        }
    }
    
    func fetchDataFromCoreData() -> DynamicsCache?{
        request.includesPropertyValues = true
        request.returnsObjectsAsFaults = false
        return try! context.fetch(request).first
    }
    
    func paseDataToJSON(data:Data) -> [DynamicsModel]? {
        
        let json = JSON(data: data)
        
        guard !json.isEmpty else {
            return nil
        }
        var res = [DynamicsModel]()
        for i in json {
            let dymamic = DynamicsModel(json: i.1)
            res.append(dymamic)
        }
        return res
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MomentsCell", for: indexPath)
        let value = dynamics[indexPath.row]
        cell.textLabel?.text = "\(value.userName)"
        return cell
    }
}
