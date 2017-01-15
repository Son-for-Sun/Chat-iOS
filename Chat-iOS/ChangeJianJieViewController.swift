//
//  ChangeJianJieViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/12.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import SwiftyJSON
class ChangeJianJieViewController: UIViewController {

    var user: User!
    
    @IBOutlet weak var jianjieTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        jianjieTextView.text = user.profile
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(okChanged))
    }
    
    func okChanged() -> Void {
        let value = jianjieTextView.text
        UserRouterMoyaProvider.request(UserRouterMoya.changeProfile(id: user.id, profile: value!)) { (result) in
            switch result {
            case .failure(_):
                break
            case .success(let response):
                let json = JSON(data: response.data)
                if json["success"].boolValue {
                  self.user.profile = value!
                  self.navigationController?.popViewController(animated: true)
                }else {
                    print("修改失败")
                }
            }
        }

    }
}
