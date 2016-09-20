//
//  ChatListTableViewCell.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/1.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var chatValue: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userphoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setupCell(chat: ChatList) {
        time.text = chat.time
        chatValue.text = chat.chatValue
        username.text = chat.userName
    }
}
