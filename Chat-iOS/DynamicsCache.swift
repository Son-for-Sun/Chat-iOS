//
//  DynamicsCache.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/20.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import CoreData

class DynamicsCache: NSManagedObject, ManagedObjectType {
    
    static var entityName: String {return "DynamicsCache"}
    
    @NSManaged var cacheData: Data
    
    
}
