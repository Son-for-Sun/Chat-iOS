//
//  DynamicsValueInformationViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/9/21.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DynamicsValueInformationViewController: UIViewController {

    @IBOutlet weak var leabelte: UILabel!
    @IBOutlet weak var button: UIButton!
    
    private let disposeBag = DisposeBag()
    var dynamic: DynamicsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        button.rx.tap.subscribe { [weak self] (event) in
            switch event {
            case .next:
                self?.leabelte.text = "1"
            default:
                break
            }
        }.addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
