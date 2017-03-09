//
//  AppDelegate.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/24.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

let baseUrl = "http://192.168.0.103:8181"
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
      let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! RootTabBarViewController
      window = UIWindow()
      window?.rootViewController = UserData.isLogin.storedBool ? mainViewController : UserViewController()
      window?.makeKeyAndVisible()
      realm = setDefaultRealmForUser(username: "chat-iOS", version: 1)
      return true
  }

 
    
}

