//
//  AddFriendsViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/30.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class AddFriendsViewController: UIViewController {

    @IBOutlet weak var userphonenumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        userphonenumber.becomeFirstResponder()

    }
}

extension AddFriendsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.text
        let defaults = UserDefaults.standard
        let _ = defaults.value(forKey: "userdata") as? Data

//        let usermodel = Friend()
//        guard let user = usermodel else {
//            return false
//        }
//        _ = user.loginname
//        RequestAPI.share.exeRequest(router: FriendsRouter.addNewFriend(userPhoneNumber: userPhoneNumber, friendPhoneNumber: friendPhoneNumber!)) { (res) in
//            print(res.result.value)
//        }
        return true
    }
}
