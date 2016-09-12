//
//  ChangeJianJieViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/12.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class ChangeJianJieViewController: UIViewController {

    var user: UserModel!
    
    @IBOutlet weak var jianjieTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        jianjieTextView.text = user.profile
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(okChanged))
    }
    
    func okChanged() -> Void {
        let value = jianjieTextView.text
        
        RequestAPI.share.exeRequest(router: UserRouter.changeProfile(id: user.id, profile: value!)) { (response) in
            let json = JSON(data: response.data!)
            if json["success"].boolValue {
                print("修改成功")
            }else {
                print("修改失败")
            }
        }
    }
}