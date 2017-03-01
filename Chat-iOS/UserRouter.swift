//
//  UserRouter.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/26.
//  Copyright © 2016年 xiaolei. All rights reserved.
//


import Moya


enum UserRouterMoya {
    case login(name: String, pass: String)
    case showUser(name: String)
    case newUser(name: String, pass: String, phoneNum: String, email: String)
    case changeName(id: String, newName: String)
    case changePass(phoneNumber: String, newPass: String)
    case changeAvatar(id: String, avatar: String)
    case changeLocation(id: String, location: String)
    case changeSignature(id: String, signature: String)
    case changeProfile(id: String, profile: String)
  
  case addNewFriend(one: String, two: String)
  case fetchFriiend(id: String)
}

extension UserRouterMoya: TargetType {
    var baseURL: URL {
        return URL(string: "http://localhost:8181/v1/users")!
    }
    var path: String {
        switch self {
        case .login:
            return  "/login"
        case .showUser(let name):
            return "byid/\(name)"
        case .newUser:
            return "/newuser"
        case .changeName:
            return "/changeName"
        case .changePass:
            return "/changePass"
        case .changeAvatar:
            return "/changeAvatar"
        case .changeLocation:
            return "/changeLocation"
        case .changeSignature:
            return "/changeSignature"
        case .changeProfile:
            return "/changeProfile"
        case .addNewFriend:
            return "/addfriend"
        case .fetchFriiend:
            return "/fetchfriend"
        }
    }
    var method: Moya.Method {
        switch self {
        case .showUser:
            return .get
        default:
            return .post
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case let .login(name, pass):
            return ["name":name,"pass":pass]
        case .showUser:
            return nil
        case let .newUser(name, pass, phoneNum, email):
            return ["name":name,"pass":pass,"loginname":phoneNum,"email":email]
        
        case let .changeName(id, newName):
            return ["id":id,"name":newName]
        case let .changePass(phoneNumber, newPass):
            return ["loginname":phoneNumber,"pass":newPass]
        case let .changeAvatar(id, avatar):
            return ["id":id,"avatar":avatar]
        case let .changeLocation(id, location):
            return ["id":id,"location":location]
        case let .changeSignature(id, signature):
            return ["id":id,"signature":signature]
        case let .changeProfile(id, profile):
            return ["id":id,"profile":profile]
        case let .addNewFriend(one, two):
            return ["one":one,"two":two]
        case let .fetchFriiend(id):
            return ["id":id]
        }
    }
    var sampleData: Data { return "fdfd".data(using: String.Encoding.utf8)! }
    
    var task: Task { return .request }
  
    var parameterEncoding: ParameterEncoding { return URLEncoding.default }
}

let UserRouterMoyaProvider = MoyaProvider<UserRouterMoya>()


