//
//  AppDelegate.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/24.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    //MARK: CoreData Container
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Chat-iOS")
        container.loadPersistentStores(completionHandler: { (persistentStoreDescription, error) in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
}

