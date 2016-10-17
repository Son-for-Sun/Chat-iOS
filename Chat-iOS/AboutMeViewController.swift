//
//  AboutMeViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import QueryKit
import DATAStack
class AboutMeViewController: UIViewController {

    @IBOutlet weak var sign: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var phonenumber: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backimage: UIImageView!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var vcon: NSLayoutConstraint!
    @IBOutlet weak var profiletextview: UITextView!
    
    let viewContext = dataStack.viewContext
    let defaults = UserDefaults.standard
    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        vcon.constant = (view.bounds.size.width * (9 / 16) - view.bounds.size.height / 2) / 2
        userPhoto.layer.cornerRadius = 111 / 2
        let tapBackimage = UITapGestureRecognizer(target: self, action: #selector(tapBackImageAction))
        backimage.addGestureRecognizer(tapBackimage)
        
        let tapUsrePhoto = UITapGestureRecognizer(target: self, action: #selector(tapUserPhotoAction))
        userPhoto.addGestureRecognizer(tapUsrePhoto)
        
        /// 从 CoreData 中获取数据
        let querySet = QuerySet<User>(viewContext, User.entityName)

        do {
            
            let users = try querySet.first()
            print(users)
            guard let user = users else {
                
                return
            }
            
            self.user = user
            name.text = user.name
            sign.text = user.signature
            emaillabel.text = user.email
            phonenumber.text = user.loginname
            profiletextview.text = user.profile
        }catch {
            print("Core Data 获取数据失败")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
//        if user.hasChanges {
//            try! viewContext.save()
//            name.text = user.name
//            sign.text = user.signature
//            emaillabel.text = user.email
//            phonenumber.text = user.loginname
//            profiletextview.text = user.profile
//        }
    }
    func tapBackImageAction() {
        print("更换背景图")
    }
    
    func tapUserPhotoAction() {
        print("更换头像")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let id = segue.identifier!
        switch id {
        case "gomoreinformation":
            let vc = segue.destination as! UserMoreInformationTableViewController
            print(self.user)
            vc.user = self.user
        default:
            break
        }
    }
    
}
