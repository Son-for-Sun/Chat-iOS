//
//  ChatViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/12.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import SocketIO

class ChatViewController: UIViewController {

    var user: UserModel!
    var friend: UserModel!
    
    var webSocket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webSocket = SocketIOClient(socketURL: URL(string: "http://localhost:3001")!)
        
        webSocket.on("message") {data, ack in
            let json = JSON(data.first!)
            print(json["hello"].stringValue)
            
        }
        webSocket.connect()
    }



}
