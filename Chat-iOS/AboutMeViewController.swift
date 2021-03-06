//
//  AboutMeViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {

    @IBOutlet weak var sign: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var phonenumber: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backimage: UIImageView!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var vcon: NSLayoutConstraint!
    @IBOutlet weak var profiletextview: UITextView!
    
  
    var user: User!
	var userHeaderImg: UIImage?
	var backImg:UIImage?
  
  enum PhoneType {
    case userPhone
    case backImage
  }
  
  var phoneType: PhoneType = .userPhone
  
   lazy var imagePicker: UIImagePickerController = {
    let imagePickerController = UIImagePickerController()
    return imagePickerController
  }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        vcon.constant = (view.bounds.size.width * (9 / 16) - view.bounds.size.height / 2) / 2
		//   userPhoto.layer.cornerRadius = 111 / 2
        let tapBackimage = UITapGestureRecognizer(target: self, action: #selector(tapBackImageAction))
        backimage.addGestureRecognizer(tapBackimage)
        
        let tapUsrePhoto = UITapGestureRecognizer(target: self, action: #selector(tapUserPhotoAction))
		
        userPhoto.addGestureRecognizer(tapUsrePhoto)
        
        /// 从 Realm 中获取数据
        user = User.fetchCurrentUser()!
    }

    func tapBackImageAction() {
      phoneType = .backImage
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      imagePicker.sourceType = .photoLibrary
      self.present(imagePicker, animated: true, completion: nil)
      
    }
    
    func tapUserPhotoAction() {
        phoneType = .userPhone
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let id = segue.identifier!
        switch id {
        case "gomoreinformation":
            let vc = segue.destination as! UserMoreInformationTableViewController
            vc.user = self.user
			vc.userHeaderImg = userHeaderImg ?? UIImage(named: "头像")
		//	vc.backImg = backImg
        default:
            break
        }
    }
	
	
	
    
}

extension AboutMeViewController: UINavigationControllerDelegate {
  
}

extension AboutMeViewController: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
      return
    }
    switch phoneType {
    case .backImage:
      backimage.image = image
	  backImg = image
      backimage.contentMode = .scaleAspectFill

    default:
      userPhoto.contentMode = .scaleAspectFill
      userPhoto.image = image
	  userHeaderImg = image
      let data = image.compressedData()!.base64EncodedData()
      
      UserRouterMoyaProvider.request(UserRouterMoya.changeUserPhone(id: user.id, image: data), completion: { (result) in
        switch result {
        case .failure(let error):
          print("errroe")
          break
        case .success(let value):
          print(try! value.mapJSON())
          break
        }
      })
    }

    picker.dismiss(animated: true, completion: nil)
  }
  
 
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}
