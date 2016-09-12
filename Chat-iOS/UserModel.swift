//
//  UserModel.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/30.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
struct UserModel {
    
    var v = ""
    var id = ""
    var avatar = ""
    var email = ""
    var location = ""
    var loginname = ""
    var name = ""
    var pass = ""
    var profile = ""
    var signature = ""
    
    
    init?(fromData data: Data?){
        guard let data = data else {
            return nil
        }
        let json = JSON(data: data)
        
        guard !json.isEmpty else {
            return nil
        }
        v = json["__v"].stringValue
        id = json["_id"].stringValue
        avatar = json["avatar"].stringValue
        email = json["email"].stringValue
        location = json["location"].stringValue
        loginname = json["loginname"].stringValue
        name = json["name"].stringValue
        pass = json["pass"].stringValue
        profile = json["profile"].stringValue
        signature = json["signature"].stringValue
    }
}
