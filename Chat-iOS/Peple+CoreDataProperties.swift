//
//  Peple+CoreDataProperties.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/29.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import CoreData

extension Peple {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Peple> {
        return NSFetchRequest<Peple>(entityName: "Peple");
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int64

}
