//
//  FriendDynamics.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/20.
//  Copyright © 2016年 xiaolei. All rights reserved.
//


import Moya

let friendDynamicRXprovider = RxMoyaProvider<FriendDynamics>()

enum FriendDynamics {
    
    case add(userid: String, userName: String, userava: String, vaslue: String, pushdate: String)
    case show(pushdate: String)
    
}



extension FriendDynamics: TargetType {
    var baseURL: URL { return URL(string: "http://localhost:3000/api/life")! }
    
    var path: String {
        switch self {
        case .add:
            return "/newlife"
        default:
            return "/selecall"
        }
    }
    
    var method: Moya.Method { return .POST }
    
    var parameters: [String: Any]? {
        switch self {
        case let .add(userid, userName, userava, vaslue, pushdate):
            return ["userid":userid,"userName":userName,"userava":userava,"vaslue":vaslue,"pushdate":pushdate]
            
        case .show(let pushdate):
            return ["pushdate":pushdate]
        }
    }
    var sampleData: Data { return "yangxiaoeli".data(using: String.Encoding.utf8)! }
    var task: Task { return .request }
}
