//
//  PushNewFriendDynamicsViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/21.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit



protocol PushNewFriendDynamicsDelegate {
    func didPushNewFriendDynamics()
}
class PushNewFriendDynamicsViewController: UIViewController {

    @IBOutlet weak var pushtextview: UITextView!
    
    
    
    var use: User!

    
    var delegate: PushNewFriendDynamicsDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "发布新的动态"

    }
    
    

    @IBAction func pushText(_ sender: AnyObject) {
        let value = pushtextview.text
        guard  let pushvalue = value else {
            return
        }

    }
    


}
