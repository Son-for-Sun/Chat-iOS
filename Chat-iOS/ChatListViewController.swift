//
//  ChatListViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import SocketIO

class ChatListViewController:UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    let socket = SocketIOClient(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .forcePolling(true)])
    
    
    var chatList = [ChatList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
        socket.emit("new user", "yangxiaolei")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        socket.on("usernames") { (data, ack) in
            print(data)
        }

    }

@IBAction func chatToAbout(_ sender: UIBarButtonItem) {
        
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: UserDefaultsKeys.isLogin.rawValue) {
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

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}


