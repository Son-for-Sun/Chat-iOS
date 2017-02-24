//
//  RegisViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/30.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class RegisViewController: UIViewController {

  @IBAction func cancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
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
              debugPrint("user information is empty")
            return
        }
        guard !pass.isEmpty && !email.isEmpty && !nicheng.isEmpty && !logname.isEmpty else {
              debugPrint("user information is empty")
            return
        }
        
        UserRouterMoyaProvider.request(UserRouterMoya.newUser(name: nicheng, pass: pass, phoneNum: logname, email: email)) { (result) in
            switch result {
            case .success(let value):
              guard let _ = value.data.mapObject(type: User.self) else {
                debugPrint("usesr regis error")
                return
              }
              self.dismiss(animated: true, completion: nil)
            case .failure(_):
              debugPrint("user regis error")
                break
            }

        }}

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
