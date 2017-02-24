//
//  UserDefaultsKeys.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/12.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation

public protocol UserDefaultSettable {
  var uniqueKey: String { get }
}

extension UserDefaultSettable where Self: RawRepresentable, Self.RawValue == String {
  func store(value: Any?) {
    UserDefaults.standard.set(value, forKey: uniqueKey)
  }
  
  var storedValue: Any? {
    return UserDefaults.standard.value(forKey: uniqueKey)
  }
  
  var storedString: String? {
    return storedValue as? String
  }
  
  func store(url: URL?) {
    UserDefaults.standard.set(url, forKey: uniqueKey)
  }
  
  var storedURL: URL? {
    return UserDefaults.standard.url(forKey: uniqueKey)
  }
  
  func store(value: Bool) {
    UserDefaults.standard.set(value, forKey: uniqueKey)
  }
  
  var storedBool: Bool {
    return UserDefaults.standard.bool(forKey: uniqueKey)
  }
  
  func store(value: Int) {
    UserDefaults.standard.set(value, forKey: uniqueKey)
  }
  
  var storedInt: Int {
    return UserDefaults.standard.integer(forKey: uniqueKey)
  }
  
  func store(value: Double) {
    UserDefaults.standard.set(value, forKey: uniqueKey)
  }
  
  var storedDouble: Double {
    return UserDefaults.standard.double(forKey: uniqueKey)
  }
  
  func store(value: Float) {
    UserDefaults.standard.set(value, forKey: uniqueKey)
  }
  
  var storedFloat: Float {
    return UserDefaults.standard.float(forKey: uniqueKey)
  }
  
  var uniqueKey: String {
    return "\(Self.self).\(rawValue)"
  }
  
  func removed() {
    UserDefaults.standard.removeObject(forKey: uniqueKey)
  }
}

enum UserData: String, UserDefaultSettable {
    case isLogin
    case userName
}
