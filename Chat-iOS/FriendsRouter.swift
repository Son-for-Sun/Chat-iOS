//
//  FriendsRouter.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/30.
//  Copyright © 2016年 xiaolei. All rights reserved.
//


import Moya

let friendsRouterProvider = MoyaProvider<FriendsRouter>()

enum FriendsRouter {
    
    case addNewFriend(userPhoneNumber:String,friendPhoneNumber:String)
    case deletFriend(userPhoneNumber:String,friendPhoneNumber:String)
}

extension FriendsRouter: TargetType {
    var baseURL: URL { return URL(string: "http://localhost:3000/api/friend")! }
    var path: String {
        switch self {
        case .addNewFriend:
            return "/newfriend"
        case .deletFriend:
            return "/deleteFriend"
        }
    }
    var method: Moya.Method { return .POST }
    var parameters: [String: Any]? {
        switch self {
        case .addNewFriend(let userPhoneNumber, let friendPhoneNumber):
            return ["name1":userPhoneNumber,"name2":friendPhoneNumber]
        case .deletFriend(let userPhoneNumber, let friendPhoneNumber):
            return ["name1":userPhoneNumber,"name2":friendPhoneNumber]
        }
    }
    var sampleData: Data { return "yangxiaolei".data(using: String.Encoding.utf8)! }
    var task: Task { return .request }

}
