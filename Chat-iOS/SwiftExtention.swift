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
/// 需要从 JSON 到 Model 转换的模型 来继承这个协议
protocol ALSwiftyJSONAble {
    
    init?(jsonData: JSON)
}




/// Extension for processing Responses into Mappable objects through ObjectMapper
extension ObservableType where E == Response {
    
    /// Maps data received from the signal into an object which implements the ALSwiftyJSONAble protocol.
    /// If the conversion fails, the signal errors.
    func mapObject<T: ALSwiftyJSONAble>(type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(T.self))
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the ALSwiftyJSONAble protocol.
    /// If the conversion fails, the signal errors.
    func mapArray<T: ALSwiftyJSONAble>(type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self))
        }
    }
}

/// 扩展 Moya response ，来使得可以直接将数据 转换到 数据模型
extension Response {
    
    /// 将数据转换成一个模型
    ///
    /// - parameter type: 继承了ALSwiftyJSONAble协议的类型
    ///
    /// - throws: 如果JSON转换错误 抛出异常
    ///
    /// - returns: 返回数据模型
    func mapObject<T: ALSwiftyJSONAble>(_ type:T.Type) throws -> T {
        let jsonObject = try mapJSON()
        
        guard let mappedObject = T(jsonData: JSON(jsonObject)) else {
            throw Moya.Error.jsonMapping(self)
        }
        
        return mappedObject
    }
    
    
    /// 将数据转换成一个模型数组
    ///
    /// - parameter type: 继承了ALSwiftyJSONAble协议的类型
    ///
    /// - throws: 如果JSON转换错误抛出异常
    ///
    /// - returns: 返回模型数组
    func mapArray<T: ALSwiftyJSONAble>(_ type:T.Type) throws -> [T] {
        let jsonObject = try mapJSON()
        
        let mappedArray = JSON(jsonObject)
        /// flat map  将空的json对象已经过滤掉了
        let mappedObjectsArray = mappedArray.arrayValue.flatMap { T(jsonData: $0) }
        
        return mappedObjectsArray
    }
    
}

extension Data {
    
    /// 将data类型转换成 数据模型对象
    ///
    /// - parameter type: 继承ALSwiftyJSONAble协议的类型
    ///
    /// - returns: 返回一个可能是 nil 的数据对象模型
    func mapObject<T: ALSwiftyJSONAble>(type: T.Type) -> T? {
        
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
    func mapObjectsArray<T: ALSwiftyJSONAble>(type: T.Type) -> [T]?{
        
        let anyObject = try? JSONSerialization.jsonObject(with: self, options: [.allowFragments])
        
        guard let _anyObject = anyObject else { return nil }
        
        let mappedArray = JSON(_anyObject)
        
        let anyObjectsArray = mappedArray.arrayValue.flatMap{ T(jsonData: $0)}
        
        return anyObjectsArray
    }
}
