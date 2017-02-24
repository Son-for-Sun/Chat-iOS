//
//  UserViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2017/2/23.
//  Copyright © 2017年 xiaolei. All rights reserved.
//

import UIKit
import SnapKit
import SwifterSwift
class UserViewController: UIViewController {
  override func viewDidLoad() {
    self.setUp()
  }
}

// MARK: - 初始化
extension UserViewController {
  fileprivate func setUp() {
    
    let bgImage = UIImageView(image: #imageLiteral(resourceName: "LaunchImage"))
    bgImage.contentMode = .scaleAspectFill
    bgImage.frame = view.bounds
    view.addSubview(bgImage)
    
    // 添加按钮
    let margin: CGFloat = 20
    let btnW: CGFloat = (SwifterSwift.screenWidth - 3.0 * margin) * 0.5
    let btnH: CGFloat = 45
    
    let loginButton = UIButton()
    loginButton.setTitle("登陆", for: .normal)
    loginButton.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
    loginButton.setTitleColor(.black, for: .normal)
    loginButton.setTitleColor(.darkGray, for: .highlighted)
    loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    view.addSubview(loginButton)
    loginButton.snp.makeConstraints { (make) in
      make.left.equalTo(view).offset(margin)
      make.width.equalTo(btnW)
      make.height.equalTo(btnH)
      make.bottom.equalTo(view).offset(-margin)
    }
    
    let registerButton = UIButton()
    registerButton.setTitle("注册", for: .normal)
    registerButton.backgroundColor = UIColor(red: 0.15, green: 0.67, blue: 0.16, alpha: 1.0)
    registerButton.setTitleColor(UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0), for: .normal)
    registerButton.setTitleColor(UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.30), for: .highlighted)
    registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    view.addSubview(registerButton)
    registerButton.snp.makeConstraints { (make) in
      make.right.equalTo(view).offset(-margin)
      make.width.height.bottom.equalTo(loginButton)
    }
  }
  
  func login() {
    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
    present(loginVC, animated: true, completion: nil)
  }
  
  func register() {
    let registerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "zhuce") as! RegisViewController
    present(registerVC, animated: true, completion: nil)
  }
}
