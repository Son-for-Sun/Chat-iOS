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
	@IBOutlet weak var placelabel: UILabel!
    
	
    
    var use = User.fetchCurrentUser()!

    
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
      
        friendDynamicProvider.request(FriendDynamics.add(userid: use.id, vaslue: pushvalue)) { (result) in
          switch result {
          case .failure(let error):
            print(error.localizedDescription)
          case .success(let response):
            print(try! response.mapJSON())
          }
      }
    }

}

extension PushNewFriendDynamicsViewController: UITextViewDelegate {
	func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		self.placelabel.isHidden = true
		return true
	}
}


