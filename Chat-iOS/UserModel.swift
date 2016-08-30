//
//  UserModel.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/30.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import Foundation
struct UserModel {
    let id: String
    let avatar: String
    let email: String
    let location: String
    let loginname: String
    let name: String
    let profile: String
    let signature: String
    
    init(id:String,avatar:String,email:String,location:String,loginname:String,name:String,profile:String,signature:String) {
        self.avatar = avatar
        self.email = email
        self.id = id
        self.location = location
        self.loginname = loginname
        self.name = name
        self.profile = profile
        self.signature = signature
    }
    init?(formDic jsonDic:NSDictionary?) {
        guard let jsonDic = jsonDic else {
            return nil
        }
        let _id = jsonDic["_id"] as? String
        let _email = jsonDic["email"] as? String
        let _loginname = jsonDic["loginname"] as? String
        let _name = jsonDic["name"] as? String
        let _avatar = jsonDic["avatar"] as? String
        let _location = jsonDic["location"] as? String
        let _profile = jsonDic["profile"] as? String
        let _signature = jsonDic["signature"] as? String
        guard let id = _id,
            let email = _email,
            let loginname = _loginname,
            let name = _name,
            let avatar = _avatar,
            let location = _location,
            let profile = _profile,
            let signature = _signature else {
                return nil
        }
        self.init(id:id,avatar:avatar,email:email,location:location,loginname:loginname,name:name,profile:profile,signature:signature)
    }
    
    init?(fromData data:Data?){
        
        guard let data = data else { return nil }
        let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let dic = jsonData as? NSDictionary
        guard let jsonDic = dic else {
            return nil
        }
        self.init(formDic: jsonDic)

        let de = UserDefaults.standard
        de.set(data, forKey: "userdata")
        de.synchronize()
    }
}
