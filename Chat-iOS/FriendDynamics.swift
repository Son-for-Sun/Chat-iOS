//
//  FriendDynamics.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/20.
//  Copyright © 2016年 xiaolei. All rights reserved.
//


import Moya


let friendDynamicProvider = MoyaProvider<FriendDynamics>()


enum FriendDynamics {
    
    case add(userid: String, vaslue: String)
    case show
    
}

extension FriendDynamics: TargetType {
    var parameterEncoding: ParameterEncoding { return URLEncoding.default }
    var baseURL: URL { return URL(string: "http://192.168.0.117:8181/:8181/v1/post")! }
    
    var path: String {
        switch self {
        case .add:
            return "/store"
        default:
            return "/all"
        }
    }
    
    var method: Moya.Method {
      switch self {
      case .add:
         return .post
      default:
        return .get
      }
  }
    
    var parameters: [String: Any]? {
        switch self {
        case let .add(userid,vaslue):
            return ["userid":userid,"vaslue":vaslue]
            
        case .show:
          return nil
        }
    }
    var sampleData: Data { return "yangxiaoeli".data(using: String.Encoding.utf8)! }
    var task: Task { return .request }
}
