//
//  ChatList.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/18.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
import CoreData

class ChatList: NSManagedObject {
    
    @NSManaged var id: String
    @NSManaged var userName: String
    @NSManaged var userPhoto: String
    @NSManaged var time: String
    @NSManaged var chatValue: String
}

extension ChatList: ManagedObjectType {
    static var entityName: String { return "ChatList"}
}
