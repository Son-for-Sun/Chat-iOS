//
//  DynamicsModel.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/20.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DynamicsModel: SwiftyJSONAble {
    
    /// 用户ID
    var user: User
    /// 用户的朋友圈内容
    var pushvalue: String

    
    init?(jsonData json: JSON) {
        guard json["owner"].exists()
        else { return nil }
        user = User(jsonData: json["owner"])!
        pushvalue = json["value","content"].stringValue
    }
}

