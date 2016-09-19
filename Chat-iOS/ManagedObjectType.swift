//
//  ManagedObjectType.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/18.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import CoreData
protocol ManagedObjectType: class {
    static var entityName: String {get}
    static var defaultSortDescriptioin: [NSSortDescriptor] {get}
}

extension ManagedObjectType {
    static var defaultSortDescriptioin: [NSSortDescriptor] {
        return []
    }
    
    
    static var sortedFetchRequest: NSFetchRequest<NSManagedObject> {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptioin
        return request
    }
}
