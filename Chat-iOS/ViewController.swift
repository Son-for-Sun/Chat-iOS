//
//  ViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/24.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
let baseURL = "http://localhost:3000/api"
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //requestuser()
        //newuser()
        changeName()
        changeLocation()
        changeavatar()
    }
    
    func newuser() {
        request("http://localhost:3000/api/user/newUser", withMethod: .post, parameters: ["name":"yangxiaolei","loginname":"1414225","pass":"xiaolei1,.","email":"1414225@aqq.com"]).responseJSON { (res) in
            print(res.result.value)
        }
    }
    
    func requestuser() {
        request("http://localhost:3000/api/user/yyyy", withMethod: .get).responseJSON { (res) in
            print(res.result.value)
        }
    }
    
    func changeName() {
        request(baseURL + "/user/newname", withMethod: .post, parameters: ["id":"57beb369c92ce3ddebd52019","newname":"fdfdfd晓磊"]).responseJSON { (res) in
            print(res.result.value)
        }
    }
    
    func changePass() {
        request(baseURL + "/user/changepass", withMethod: .post, parameters: ["loginname":"57bea9c4771af7d7da427b62","newpass":"杨晓磊"]).responseJSON { (res) in
            print(res.result.value)
        }
    }
    
    func changeLocation() {
        request(baseURL + "/user/updatelocation", withMethod: .post, parameters: ["id":"57beb369c92ce3ddebd52019","newlocation":"太原"])
            .validate()
            .responseJSON { (res) in
            print(res.result.value)
        }
    }
    func changeavatar()  {
        request(baseURL + "/user/updateavatar", withMethod: .post, parameters: ["id":"57beb369c92ce3ddebd52019","newavatar":"dfdfdf"]).responseJSON { (re) in
            print(re.result.value)
        }
    }
   // router.post('/user/newname',userController.updatename)
   // router.post('/user/changepass',userController.updatepass)
   // router.post('/user/updateavatar',userController.updateavatar)
   // router.post('/user/updatelocation',userController.updatelocation)
   // router.post('/user/updatesignature',userController.updatesignature
}

