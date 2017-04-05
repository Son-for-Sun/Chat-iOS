//
//  ChatModel.swift
//  Chat-iOS
//
//  Created by xiaolei on 2017/3/11.
//  Copyright © 2017年 xiaolei. All rights reserved.
//

import Starscream
import SwiftyJSON
private let chatURL = URL(string: "ws://192.168.0.103:8181/chat")!

internal class ChatModel {
  
  let webSocket = WebSocket(url: chatURL)
  lazy var username: String! = "null"
  
  // Probably not best to store here, but just trying to get something up quickly
  weak var controller: UIViewController?
  
  init(_ controller: UIViewController) {
    self.controller = controller
    
  }
  
  func start() {
    webSocket.onConnect = { [unowned webSocket, weak self] in
      guard let username = self?.username else { return }
      webSocket.write(string: "{\"username\":\"\(username)\"}")
    }
    
    webSocket.onText = { [unowned self] text in
      
      let js = JSON.init(parseJSON: text)
      print(text)
      guard
        let username = js["username"].string ,
        let content = js["message"].string
        else { return }
//      let message = ChatMessage(sentBy: .opponent, content: "\(username): \(content)", timeStamp: nil, imageUrl: nil)
//      self.controller?.addNewMessage(message)
      print(username,content)
    }
    
    webSocket.onDisconnect = { [weak self] err in
//      self?.controller?.showDisconnect()
    }
    
    webSocket.connect()
  }
  
  func send(msg: String) {
    let json = "{\"username\":\"\(username)\",\"message\":\"\(msg)\"}"
    webSocket.write(string: json)
  }
}
