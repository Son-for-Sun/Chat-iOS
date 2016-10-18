//
//  UserRouter.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/26.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import PromiseKit
import SwiftyJSON
let UserRouterMoyaProvider = MoyaProvider<UserRouterMoya>()

extension MoyaProvider {
    
    /// 结合 PromiseKit 获取 moyaProvider 请求
    ///
    /// - parameter target: 请求的目标
    ///
    /// - returns: Promise<Data>
    func request(_ target: Target) -> Promise<Data> {
        
        return Promise(resolvers: { (fulfill, reject) in
            self.request(target) { (result) in
                switch result {
                case .success(let value):
                    return fulfill(value.data)
                case .failure(let error):
                    return reject(error)
                }
            }
        })
    }
}
extension Response {
    func mapJSON(data: Data) -> Promise<JSON> {
        
        return Promise{ fulfill, reject in
            do {
                let any = try self.mapJSON()
                let json = JSON(any)
                fulfill(json)
            }catch {
                reject(NSError())
            }
        }
    }
    
    func mapObject<T: ALSwiftyJSONAble>(json: JSON) -> Promise<T> {
        return Promise{ fulfill, reject in
            do {
                let object = try mapObject(T.self)
                fulfill(object)
            }catch {
                reject(NSError())
            }
        }
    }
}

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
}

extension UserRouterMoya: TargetType {
    var baseURL: URL {
        return URL(string: "http://localhost:3000/api/user")!
    }
    var path: String {
        switch self {
        case .login:
            return  "/login"
        case .showUser(let name):
            return "/\(name)"
        case .newUser:
            return "/newUser"
        case .changeName:
            return "/newname"
        case .changePass:
            return "/changepass"
        case .changeAvatar:
            return "/updateavatar"
        case .changeLocation:
            return "/updatelocation"
        case .changeSignature:
            return "/updatesignature"
        case .changeProfile:
            return "/updatepro"
        }
    }
    var method: Moya.Method {
        switch self {
        case .showUser:
            return .GET
        default:
            return .POST
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
    var sampleData: Data { return "fdfd".data(using: String.Encoding.utf8)! }
    
    var task: Task { return .request }
}


