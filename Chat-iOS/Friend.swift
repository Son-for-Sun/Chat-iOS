//
//  Friend.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/19.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON


struct FriendsList: SwiftyJSONAble {
    var name: String
    
    init?(jsonData:SwiftyJSON.JSON) {
        guard let  name = jsonData["friend"].string else {
            return nil
        }
        self.name = name
    }
}

struct Friend: SwiftyJSONAble {
    
     var v: String
     var id: String
     var avatar: String
     var email: String
     var location: String
     var loginname: String
     var name: String
     var pass: String
     var profile: String
     var signature: String
    
     init?(jsonData:SwiftyJSON.JSON) {
        v = jsonData["__v"].stringValue
        id = jsonData["_id"].stringValue
        avatar = jsonData["avatar"].stringValue
        email = jsonData["email"].stringValue
        location = jsonData["location"].stringValue
        loginname = jsonData["loginname"].stringValue
        name = jsonData["name"].stringValue
        pass = jsonData["pass"].stringValue
        profile = jsonData["profile"].stringValue
        signature = jsonData["signature"].stringValue
    }


}

