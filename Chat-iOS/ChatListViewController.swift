//
//  ChatListViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire
import SocketIO

class ChatListViewController:UIViewController {
    

    @IBOutlet weak var tableView: UITableView!

    
    var webSocket: SocketIOClient!
    var chatList = [ChatListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

       webSocket = SocketIOClient(socketURL: URL(string: "http://localhost:3001")!)
        
       webSocket.on("message") {data, ack in
            print(data)
            
        }
       webSocket.connect()
    }

@IBAction func chatToAbout(_ sender: UIBarButtonItem) {
        
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "isLogin") {
            let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "about") as! AboutMeViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ChatListViewController {
    func setUpTableView() {
        
    }
}

extension ChatListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as! ChatListTableViewCell
        cell.setupCell(chat: chatList[indexPath.row])
        return cell
    }
}


