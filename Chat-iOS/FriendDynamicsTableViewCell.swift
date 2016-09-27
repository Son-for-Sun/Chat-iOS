//
//  FriendDynamicsTableViewCell.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/27.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class FriendDynamicsTableViewCell: UITableViewCell {

    @IBOutlet weak var pushvalue: UILabel!
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var username: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }



}
