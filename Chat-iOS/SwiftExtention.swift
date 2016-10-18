//
//  SwiftExtention.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/27.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import SwiftyJSON
import Moya
import RxSwift
import DATAStack
import PromiseKit
import Haneke

var dataStack: DATAStack = {
    let dataStack = DATAStack(modelName: "Chat-iOS")
    
    return dataStack
}()

/// 需要从 JSON 到 Model 转换的模型 来继承这个协议

protocol SwiftyJSONAble {
    init?(jsonData:SwiftyJSON.JSON)
}

extension Response {
    
    /// Maps data received from the signal into an object which implements the ALSwiftyJSONAble protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: SwiftyJSONAble>(type:T.Type) throws -> T {
        let jsonObject = try mapJSON()
        
        guard let mappedObject = T(jsonData: JSON(jsonObject)) else {
            throw Moya.Error.jsonMapping(self)
        }
        
        return mappedObject
    }
    
    /// Maps data received from the signal into an array of objects which implement the ALSwiftyJSONAble protocol
    /// If the conversion fails, the signal errors.
    func mapArray<T: SwiftyJSONAble>(type:T.Type) throws -> [T] {
        let jsonObject = try mapJSON()
        
        let mappedArray = JSON(jsonObject)
        let mappedObjectsArray = mappedArray.arrayValue.flatMap { T(jsonData: $0) }
        
        return mappedObjectsArray
    }
    
}

extension Data {
    
    /// Data to model
    ///
    /// - parameter type: model type
    ///
    /// - returns: promise
    func mapObject<T: SwiftyJSONAble>(type: T.Type) -> Promise<T> {
        return Promise{ fulfill, reject in
            do {
                let anObject = try JSONSerialization.jsonObject(with: self, options: [.allowFragments])
                let jsonObject = JSON(anObject)
                let object = T(jsonData: jsonObject)!
                fulfill(object)
            }catch let error {
                reject(error)
            }
        }
    }
    
    /// data to model array
    ///
    /// - parameter type: model type
    ///
    /// - returns: promise
    func mapObjectsArray<T: SwiftyJSONAble>(type: T.Type) -> Promise<[T]>{
        return Promise{ fulfill, reject in
            do {
                let anyObject = try JSONSerialization.jsonObject(with: self, options: [.allowFragments])
                let mappedArray = JSON(anyObject)
                let anyObjectsArray = mappedArray.arrayValue.flatMap{ T(jsonData: $0)}
                fulfill(anyObjectsArray)
            }catch let error {
                reject(error)
            }
        }
    }
}
extension Data {
    
    /// 将data类型转换成 数据模型对象
    ///
    /// - parameter type: 继承ALSwiftyJSONAble协议的类型
    ///
    /// - returns: 返回一个可能是 nil 的数据对象模型
    func mapObject<T: SwiftyJSONAble>(type: T.Type) -> T? {
        
        let anyObject = try? JSONSerialization.jsonObject(with: self, options: [.allowFragments])
        
        guard let _anyObject = anyObject else { return nil }
        
        let jsonObject = JSON(_anyObject)
        
        return T(jsonData: jsonObject)
    }
    

    
    /// 将data类型转换成 数据模型对象数组
    ///
    /// - parameter type: 继承ALSwiftyJSONAble协议的类型
    ///
    /// - returns: 返回一个可能是空的数据对象模型数组
    func mapObjectsArray<T: SwiftyJSONAble>(type: T.Type) -> [T]?{
        
        let anyObject = try? JSONSerialization.jsonObject(with: self, options: [.allowFragments])
        
        guard let _anyObject = anyObject else { return nil }
        
        let mappedArray = JSON(_anyObject)
        
        let anyObjectsArray = mappedArray.arrayValue.flatMap{ T(jsonData: $0)}
        
        return anyObjectsArray
    }
    

}

extension MoyaProvider {
    
    /// 结合 PromiseKit 获取 moyaProvider 请求
    ///
    /// - parameter target: 请求的目标
    ///
    /// - returns: Promise<Data>
    func request(_ target: Target) -> Promise<Response> {
        
        return Promise(resolvers: { (fulfill, reject) in
            self.request(target) { (result) in
                switch result {
                case .success(let value):
                    return fulfill(value)
                case .failure(let error):
                    return reject(error)
                }
            }
        })
    }
}

extension Response {
    
    /// response map to Swifty JSON
    /// - returns: Swifty JSON
    func mapSwiftyJSON() -> Promise<SwiftyJSON.JSON> {
        
        return Promise{ fulfill, reject in
            
            do {
                let any = try self.mapJSON()
                let json = JSON(any)
                fulfill(json)
            }catch {
                reject(Moya.Error.jsonMapping(self))
            }
        }
    }
    
    /// 将response 转换成一个 对象
    ///
    /// - returns: 对象
    func mapObjectPromise<T: SwiftyJSONAble>(type:T.Type) -> Promise<T> {
        return Promise{ fulfill, reject in
            do {
                let object = try mapObject(type: T.self)
                fulfill(object)
            }catch {
                reject(Moya.Error.jsonMapping(self))
            }
        }
    }
    
    /// 将response 转换成一个 对象数组
    ///
    /// - parameter type: 要转换的类型
    ///
    /// - returns: 对象数组
    func mapObjectArrayPromise<T: SwiftyJSONAble>(type: T.Type) -> Promise<[T]> {
        return Promise{ fulfill, reject in
            do {
                let objectarray = try mapArray(type: T.self)
                fulfill(objectarray)
            }catch {
                reject(Moya.Error.jsonMapping(self))
            }
        }
    }
}

extension Cache {
    
    func fetch(_ key: String) -> Promise<T> {
        return Promise{ fulfill, reject in
            _ = self.fetch(key: key)
                .onSuccess{ fulfill($0)}
                .onFailure{ reject($0!)}
        }
    }
    
    func set(data: T, key: String) -> Promise<T> {
        return Promise{fulfill , reject in
            set(value: data, key: key)
            fulfill(data)
        }
    }
}

