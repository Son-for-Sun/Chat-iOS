//
//  User.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/19.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import SwiftyJSON
import RealmSwift

class User: Object, SwiftyJSONAble {
  
  dynamic var avatar: String!
  dynamic var email: String!
  dynamic var id: String!
  dynamic var location: String!
  dynamic var loginname: String!
  dynamic var name: String!
  dynamic var pass: String!
  dynamic var profile: String!
  dynamic var signature: String!
  
  override class func primaryKey() -> String? { return "id" }
  override class func indexedProperties() -> [String] { return ["id"] }
  
  
  convenience required init?(jsonData:SwiftyJSON.JSON) {
        if let _ = jsonData["error"].bool {
          return nil
        }
        self.init()
        avatar = jsonData["avatar"].stringValue
        email = jsonData["email"].stringValue
        id = jsonData["id"].stringValue
        location = jsonData["location"].stringValue
        loginname = jsonData["loginname"].stringValue
        name = jsonData["name"].stringValue
        pass = jsonData["pass"].stringValue
        profile = jsonData["profile"].stringValue
        signature = jsonData["signature"].stringValue
  }
}

extension User {
  static var email = Attribute<String>("email")
  static var id = Attribute<String>("id")
}

extension User {
  static func add(user: User) {
    let realm = try! Realm()
    do {
      try realm.write {
        realm.add(user, update: true)
      }
    }catch {
      print("add user is error")
    }
  }
  
  static func fetchCurrentUser() -> User? {
    let realm = try! Realm()
    return realm.objects(User.self).first
  }
}




