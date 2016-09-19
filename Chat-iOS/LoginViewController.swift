//
//  LoginViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/30.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumber.becomeFirstResponder()
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
        
        RequestAPI.share.exeRequest(router: UserRouter.login(name: phone, pass: pass)) { [unowned self] (response) in
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let user = User(fromData: response.data, context: context)
    
            guard let _ = user else {
                return
            }
            
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: UserDefaultsKeys.isLogin.rawValue)
            defaults.synchronize()
            try! context.save()
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func gozhuce(_ sender: AnyObject) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "zhuce") as! RegisViewController
        navigationController?.pushViewController(vc, animated: true)
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
