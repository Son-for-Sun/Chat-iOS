//
//  DynamicsModel.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/20.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DynamicsModel: ALSwiftyJSONAble {
    
    /// 用户ID
    var userid: String
    
    /// 用户名称
    var userName: String
    
    /// 用户头像地址
    var userava: URL?
    
    /// 用户的朋友圈内容
    var pushvalue: String
    
    /// 发布的时间
    var pushdate: String
    
    init?(jsonData json: JSON) {
        guard let userid = json["userid"].string,
            let userName = json["userName"].string,
            let pushvalue = json["vaslue"].string,
            let pushdate = json["pushdate"].string
        else { return nil }
        
        self.userName = userName
        self.userid = userid
        self.userava = json["userava"].URL
        self.pushvalue = pushvalue
        self.pushdate = pushdate
    }
}

