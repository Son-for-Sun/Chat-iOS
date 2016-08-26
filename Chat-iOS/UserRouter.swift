//
//  UserRouter.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/26.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import Alamofire
public let baseURL = "http://localhost:3000/api"

protocol RouterProtocol {
    var requestURL: String {get}
    var requestParameters: [String:String]? {get}
    var method: HTTPMethod {get}
}
enum UserRouter:RouterProtocol {
    
    case login(name: String, pass: String)
    case showUser(name: String)
    case newUser(name: String, pass: String, phoneNum: String, email: String)
    case changeName(id: String, newName: String)
    case changePass(phoneNumber: String, newPass: String)
    case changeAvatar(id: String, avatar: String)
    case changeLocation(id: String, location: String)
    case changeSignature(id: String, signature: String)
    case changeProfile(id: String, profile: String)
    
    private var userURL: String {
        return baseURL + "/user"
    }
    
    var method: HTTPMethod {
        switch self {
        case .showUser:
            return .get
        default:
            return .post
        }
    }
    var requestURL:String {
        switch self {
        case .login:
            return userURL + "/login"
        case .showUser(let name):
            return userURL + "/\(name)"
        case .newUser:
            return userURL + "/newUser"
        case .changeName:
            return userURL + "/newname"
        case .changePass:
            return userURL + "/changepass"
        case .changeAvatar:
            return userURL + "/updateavatar"
        case .changeLocation:
            return userURL + "/updatelocation"
        case .changeSignature:
            return userURL + "/updatesignature"
        case .changeProfile:
            return userURL + "/updatepro"
        }
    }
    
    var requestParameters: [String:String]? {
        switch self {
        case let .login(name, pass):
            return ["name":name,"pass":pass]
        case .showUser:
            return nil
        case let .newUser(name, pass, phoneNum, email):
            return ["name":name,"pass":pass,"loginname":phoneNum,"email":email]
        case let .changeName(id, newName):
            return ["id":id,"newname":newName]
        case let .changePass(phoneNumber, newPass):
            return ["loginname":phoneNumber,"newpass":newPass]
        case let .changeAvatar(id, avatar):
            return ["id":id,"newavatar":avatar]
        case let .changeLocation(id, location):
            return ["id":id,"newlocation":location]
        case let .changeSignature(id, signature):
            return ["id":id,"newsignature":signature]
        case let .changeProfile(id, profile):
            return ["id":id,"profile":profile]
        }
    }
}
