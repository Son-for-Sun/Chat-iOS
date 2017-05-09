//
//  FriendInformationViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/10/19.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class FriendInformationViewController: UIViewController {

	@IBOutlet weak var backImageView: UIImageView!
    
	@IBOutlet weak var userHeaderImageView: UIImageView!
	
	@IBOutlet weak var userNameLabel: UILabel!
	
	@IBOutlet weak var userMotto: UILabel!
	@IBOutlet weak var phoneNumber: UILabel!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var introduce: UITextView!
	
    var friend: User!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(friend)
    }

	@IBAction func sendMessage(_ sender: UIButton) {
		
		
		
	}
    


}
