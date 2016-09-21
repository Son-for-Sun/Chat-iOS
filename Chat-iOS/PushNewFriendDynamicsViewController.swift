//
//  PushNewFriendDynamicsViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/21.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON
class PushNewFriendDynamicsViewController: UIViewController {

    @IBOutlet weak var pushtextview: UITextView!
    
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    var use: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "发布新的动态"
        let context = persistentContainer.viewContext
        let resquest = NSFetchRequest<User>(entityName: User.entityName)
        resquest.includesPropertyValues = true
        resquest.returnsObjectsAsFaults = false
        let users = try! context.fetch(resquest).first
        guard  let user = users else {
            self.navigationController!.popViewController(animated: true)
            return
        }
        
        use = user
    }
    
    

    @IBAction func pushText(_ sender: AnyObject) {
        let value = pushtextview.text
        guard  let pushvalue = value else {
            return
        }
        if pushvalue.characters.count > 0 {
            friendDynamicsProvider.request(FriendDynamics.add(userid: use.id, userName: use.name, userava: use.avatar, vaslue: pushvalue, pushdate: ""), completion: { (result) in
                switch result {
                case .success(let response):
                    let jsondata = JSON(data: response.data)
                    if jsondata["success"].boolValue {
                        print("发表成功")
                    }else {
                        fallthrough
                    }
                case .failure:
                    break
                }
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
