//
//  AppDelegate.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/24.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func applicationWillTerminate(_ application: UIApplication) {
        
        saveContext()
    }
    func saveContext() {
        dataStack.performInNewBackgroundContext { (back) in
            try? back.save()
        }
    }
    
}

