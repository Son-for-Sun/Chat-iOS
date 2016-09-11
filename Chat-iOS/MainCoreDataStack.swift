//
//  MainCoreDataStack.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/31.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import CoreData

protocol NSManagedObjectContextSettable:class{
    var managedObjectContext: NSManagedObjectContext! {get set}
}

public final class MainCoreDataStack {
    
//    public func createContext() -> NSManagedObjectContext{
//        
//        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType)
//    }
}
