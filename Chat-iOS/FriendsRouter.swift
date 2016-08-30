//
//  FriendsRouter.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/30.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Alamofire

enum FriendsRouter: RouterProtocol {
    
    case addNewFriend(userPhoneNumber:String,friendPhoneNumber:String)
    case deletFriend(userPhoneNumber:String,friendPhoneNumber:String)
    private var friendsURL:String {
        return baseURL + "/friend"
    }
    
    var requestURL: String {
        switch self {
        case .addNewFriend:
            return friendsURL + "/newfriend"
        case .deletFriend:
            return friendsURL + "/deleteFriend"
        }
    }
    var requestParameters: [String:String]? {
        switch self {
        case .addNewFriend(let userPhoneNumber, let friendPhoneNumber):
            return ["name1":userPhoneNumber,"name2":friendPhoneNumber]
        case .deletFriend(let userPhoneNumber, let friendPhoneNumber):
            return ["name1":userPhoneNumber,"name2":friendPhoneNumber]
        }
    }
    var method: HTTPMethod {
        return .post
    }

}
