//
//  DynamicsModel.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/20.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation

struct DynamicsModel {
    
    /// 用户ID
    var userid: String
    
    /// 用户名称
    var userName: String
    
    /// 用户头像地址
    var userava: String
    
    /// 用户的朋友圈内容
    var pushvalue: String
    
    /// 发布的时间
    var pushdate: String
    
    init(json: JSON) {
        userid = json["userid"].stringValue
        userName = json["userName"].stringValue
        userava = json["userava"].stringValue
        pushvalue = json["vaslue"].stringValue
        pushdate = json["pushdate"].stringValue
    }
}
