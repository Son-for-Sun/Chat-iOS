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
import SocketIOClientSwift
import Starscream

class ChatListViewController:UIViewController {
    

    @IBOutlet weak var tableView: UITableView!

    
    var webSocket: SocketIOClient!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        webSocket = SocketIOClient(socketURL: URL(string: "http://localhost:3000")!)
        
        webSocket.on("message") {data, ack in
            print("+++++++++++++++++++++socket connected")
        }
        webSocket.connect()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
/*
extension ChatListViewController: WebSocketDelegate, WebSocketPongDelegate {
    func websocketDidConnect(_ socket: WebSocket) {
        print("===============websocket is connected")
    }
    func websocketDidDisconnect(_ socket: WebSocket, error: NSError?) {
        print("===============websocket is disconnected: \(error?.localizedDescription)")
    }
    func websocketDidReceiveMessage(_ socket: WebSocket, text: String) {
        print("===============got some text: \(text)")
    }
    func websocketDidReceiveData(_ socket: WebSocket, data: Data) {
        print("===============got some data: \(data.count)")
    }
    
    
    func websocketDidReceivePong(_ socket: WebSocket) {
        print("=============== some data: ")
    }

}
*/
extension ChatListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}


