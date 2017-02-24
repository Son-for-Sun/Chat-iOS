//
//  AddFriendsViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/30.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON


class AddFriendsViewController: UIViewController {

    @IBOutlet weak var userphonenumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        userphonenumber.becomeFirstResponder()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        /// 判断用户是否登陆了没有登陆的话要求用户登陆
      
        if !UserData.isLogin.storedBool {
            
        }
    }
}

extension AddFriendsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let number = textField.text
//        let context = dataStack.viewContext
//        let queryset = QuerySet<User>(context, User.entityName)
//        do {
//            let users = try queryset.first()
//            guard let user = users  else {
//                return false
//            }
//            friendsRouterProvider.request(FriendsRouter.addNewFriend(userPhoneNumber: user.loginname, friendPhoneNumber: number!), completion: { (res) in
//                switch res {
//                case .success(let value):
//                    let json = JSON(data: value.data)
//                    let res = json["success"].boolValue
//                    print(res)
//                case .failure(let errror):
//                    print(errror)
//                }
//            })
//        }catch {
//            return false
//        }
        return true
    }
}
