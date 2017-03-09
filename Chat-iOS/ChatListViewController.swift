//
//  ChatListViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import AttributedLib
import Starscream
class ChatListViewController:UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
  
    var chatList = [ChatList]()
  
  
  let socket = WebSocket(url: URL(string: "ws://192.168.0.103:8181/chat")!)
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        socket.delegate = self
        socket.headers["to"] = "123"
        socket.connect()
    }
  
  override func viewDidAppear(_ animated: Bool) {
    socket.write(string: "我是杨晓磊")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    socket.write(string: "view will appear")
  }
}


extension ChatListViewController: WebSocketDelegate {
  func websocketDidConnect(socket: WebSocket) {
      socket.write(string: "Hello WebSocket")
  }
  func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
    
  }
  func websocketDidReceiveMessage(socket: WebSocket, text: String) {
      print(text)
  }
  func websocketDidReceiveData(socket: WebSocket, data: Data) {
    
  }
}

extension ChatListViewController: DZNEmptyDataSetSource {
  func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
    return .white
  }
  
  func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
    return  "没有任何聊天记录".attributed{
      return $0.font(UIFont.boldSystemFont(ofSize: 18.0))
      .foreground(color: UIColor.darkGray)
    }
  }
}

extension ChatListViewController: DZNEmptyDataSetDelegate {
  
}

extension ChatListViewController {
    func setUpTableView() {
      tableView.emptyDataSetSource = self
      tableView.emptyDataSetDelegate = self
      tableView.tableFooterView = UIView()
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


