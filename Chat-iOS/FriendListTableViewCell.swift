//
//  FriendListTableViewCell.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/1.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class FriendListTableViewCell: UITableViewCell {

    @IBOutlet weak var userphoto: UIImageView!
    @IBOutlet weak var username: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setupCell(userPhotoURL:String,userName:String) -> Void {
        username.text = userName
    }

}
