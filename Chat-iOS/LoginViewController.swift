//
//  LoginViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/30.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwifterSwift
class LoginViewController: UIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumber.becomeFirstResponder()
    }

  @IBAction func cancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
    @IBAction func login(_ sender: AnyObject) {
            userlogin()
    }
    
    func userlogin() {
        
        guard let phone = phoneNumber.text,
            let pass = self.pass.text else {
            return
        }
        guard  !phone.isEmpty && !pass.isEmpty else {
            return
        }
        /// 用户请求登陆
        UserRouterMoyaProvider.request(UserRouterMoya.login(name: phone, pass: pass)) { (result) in
          switch result {
          case .failure:
            break
          case .success(let value):
            let user = value.data.mapObject(type: User.self)
            if let user = user {
              let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! RootTabBarViewController
              SwifterSwift.sharedApplication.keyWindow?.rootViewController = mainVC
              UserData.isLogin.store(value: true)
              User.add(user: user)
            }else {
              debugPrint("user login error")
            }
          }
      }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 105 {
            pass.becomeFirstResponder()
        }else if textField.tag == 106 {
            userlogin()
        }
        return true
    }
}
