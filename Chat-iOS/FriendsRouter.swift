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
    case allFriend(userphonenumber: String)
    case addNewFriend(userPhoneNumber:String,friendPhoneNumber:String)
    case deletFriend(userPhoneNumber:String,friendPhoneNumber:String)
    case notefriend(userphonenumber: String)
    case noteagree(userphonenumber: String)
    case agereefriend(userPhoneNumber:String,friendPhoneNumber:String)
}

extension FriendsRouter: TargetType {
    var parameterEncoding: ParameterEncoding { return URLEncoding.default }
    var baseURL: URL { return URL(string: "http://localhost:3000/api/friend")! }
    var path: String {
        switch self {
        case .addNewFriend:
            return "/newfriend"
        case .deletFriend:
            return "/deleteFriend"
        case .allFriend:
            return "/all"
        case .noteagree:
            return "/noteagree"
        case .notefriend:
            return "/notefriend"
        case .agereefriend:
            return "/agereefriend"
        }
    }
    var method: Moya.Method { return .post }
    var parameters: [String: Any]? {
        switch self {
        case .addNewFriend(let userPhoneNumber, let friendPhoneNumber):
            return ["name1":userPhoneNumber,"name2":friendPhoneNumber]
        case .deletFriend(let userPhoneNumber, let friendPhoneNumber):
            return ["name1":userPhoneNumber,"name2":friendPhoneNumber]
        case .allFriend(let userphonenumber):
            return ["name":userphonenumber]
        case .noteagree(let userphonenumber):
            return ["name": userphonenumber]
        case .notefriend(let userphonenumber):
            return ["name": userphonenumber]
        case .agereefriend(let userPhoneNumber, let friendPhoneNumber):
            return ["name1":userPhoneNumber,"name2":friendPhoneNumber]
        }
    }
    var sampleData: Data { return "yangxiaolei".data(using: String.Encoding.utf8)! }
    var task: Task { return .request }

}
