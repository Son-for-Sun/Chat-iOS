//
//  User.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/19.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON
import QueryKit

final class User: NSManagedObject {
    
    @NSManaged var v: String
    @NSManaged var id: String
    @NSManaged var avatar: String
    @NSManaged var email: String
    @NSManaged var location: String
    @NSManaged var loginname: String
    @NSManaged var name: String
    @NSManaged var pass: String
    @NSManaged var profile: String
    @NSManaged var signature: String
    
    
   
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init?(fromData data: Data?, context: NSManagedObjectContext){
        guard let data = data else {
            return nil
        }
        let json = JSON(data: data)

        guard json["error"].boolValue != true else {
            return nil
        }
      
        let entity = NSEntityDescription.entity(forEntityName: User.entityName, in: context)
        super.init(entity: entity!, insertInto: context)
        v = json["__v"].stringValue
        id = json["id"].stringValue
        avatar = json["avatar"].stringValue
        email = json["email"].stringValue
        location = json["location"].stringValue
        loginname = json["loginname"].stringValue
        name = json["name"].stringValue
        pass = json["pass"].stringValue
        profile = json["profile"].stringValue
        signature = json["signature"].stringValue
    }
}

extension User: ManagedObjectType {
    static var entityName: String { return "User"}
    
    static var id:Attribute<String> { return Attribute("id") }
    static var loginname:Attribute<String> { return Attribute("loginname") }
    static var name:Attribute<String> { return Attribute("name") }
}


