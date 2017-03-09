//
//  ChatList.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/18.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import RealmSwift
class ChatList: Object  {
    
     dynamic var id: String = ""
     dynamic var userName: String = ""
     dynamic var userPhoto: String = ""
     dynamic var time: String = ""
     dynamic var chatValue: String = ""
  
    override class func primaryKey() -> String? { return "id" }
    override class func indexedProperties() -> [String] { return ["id"] }
}

