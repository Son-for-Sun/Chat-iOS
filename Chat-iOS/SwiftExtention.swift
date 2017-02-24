//
//  SwiftExtention.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/27.
//  Copyright © 2016年 xiaolei. All rights reserved.
//


import SwiftyJSON
import Moya
import SwifterSwift
import RealmSwift
/// 需要从 JSON 到 Model 转换的模型 来继承这个协议

protocol SwiftyJSONAble {
    init?(jsonData:SwiftyJSON.JSON)
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

extension SwifterSwift {
  public static var documentDir: URL {
    return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
  }
}


func setDefaultRealmForUser(username: String, version: UInt64) -> Realm {
  
  var realmConfig = Realm.Configuration(schemaVersion: version, migrationBlock: { (migration, oldSchemaVersion) in
      if oldSchemaVersion < 1 {
        // Nothing to do!
        // Realm will automatically detect new properties and removed properties
        // And will update the schema on disk automatically
      }
  })
  
  realmConfig.fileURL = realmConfig.fileURL!.deletingLastPathComponent()
    .appendingPathComponent("\(username).realm")
  
  Realm.Configuration.defaultConfiguration = realmConfig
  return try! Realm()
}

var realm: Realm!


