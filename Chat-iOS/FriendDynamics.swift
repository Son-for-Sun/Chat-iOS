//
//  FriendDynamics.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/20.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import Alamofire

enum FriendDynamics: RouterProtocol {
    
    case add(userid: String, userName: String, userava: String, vaslue: String, pushdate: String)
    case show(pushdate: String)
    
    var requestURL: String {
        switch self {
        case .add:
            return lifeURL + "/newlife"
        default:
            return lifeURL + "/selecall"
        }
    }
    var requestParameters: [String:String]? {
        switch self {
        case let .add(userid, userName, userava, vaslue, pushdate):
            return ["userid":userid,"userName":userName,"userava":userava,"vaslue":vaslue,"pushdate":pushdate]
            
        case .show(let pushdate):
            return ["pushdate":pushdate]
        }
    }
    var method: HTTPMethod { return .post}
    
    private var lifeURL: String {return baseURL + "/life"}
}
