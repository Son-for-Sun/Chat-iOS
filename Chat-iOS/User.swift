//
//  User.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/31.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import CoreData
public class ManagedObject: NSManagedObject {
    
}
public final class User: ManagedObject{
    
    @NSManaged var id: String
    @NSManaged var avatar: String
    @NSManaged var email: String
    @NSManaged var location: String
    @NSManaged var loginname: String
    @NSManaged var name: String
    @NSManaged var profile: String
    @NSManaged var signature: String
    
}
