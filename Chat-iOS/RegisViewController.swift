//
//  RegisViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/30.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class RegisViewController: UIViewController {

    @IBOutlet weak var passworld: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var nicheng: UITextField!
    @IBOutlet weak var logname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "注册新用户"
        nicheng.becomeFirstResponder()
    }


    @IBAction func addNewUser(_ sender: AnyObject) {
        addNewUserTo()
    }

    func addNewUserTo() {
        
        guard let pass = passworld.text,
              let email = self.email.text,
              let nicheng = self.nicheng.text,
              let logname = self.logname.text else {
                print("error")
            return
        }
        guard !pass.isEmpty && !email.isEmpty && !nicheng.isEmpty && !logname.isEmpty else {
            print("errrrr")
            return
        }
//        RequestAPI.share.exeRequest(router:UserRouter.newUser(name: nicheng, pass: pass, phoneNum: logname, email: email)) { (res) in
//            guard let data = res.data else {
//                return
//            }
//            do {
//                let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                guard let jsonDic = jsonData as? NSDictionary,let res = jsonDic["success"] as? Bool else {
//                    return
//                }
//                print(res)
//            }catch {
//                print("data to json is error")
//            }
//            
//            
//        }
        
    }

}

extension RegisViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 101 {
            logname.becomeFirstResponder()
        }else if textField.tag == 102 {
            email.becomeFirstResponder()
        }else if textField.tag == 103 {
            passworld.becomeFirstResponder()
        }else if textField.tag == 104 {
            addNewUserTo()
        }
        return true
    }
}
