//
//  AddFriendsViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/30.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import SwiftyJSON


class AddFriendsViewController: UIViewController {

  
    var currentUser = User.fetchCurrentUser()!
  
    @IBOutlet weak var userphonenumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        userphonenumber.becomeFirstResponder()
        userphonenumber.text = "f2a5ae58b1f7d8d0a2494982"
    }

}

extension AddFriendsViewController: UITextFieldDelegate {
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          UserRouterMoyaProvider.request(UserRouterMoya.addNewFriend(one: currentUser.id, two: textField.text!)) { (result) in
            let a = try! result.value!.mapString()
            print(a)
      }
        return true
    }
}
