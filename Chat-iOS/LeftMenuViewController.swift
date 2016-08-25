//
//  LeftMenuViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit
import RESideMenu
class LeftMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isOpaque = false
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = nil
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.scrollsToTop = false
    }
}

extension LeftMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftCell", for: indexPath)
        cell.textLabel?.text = "222"
        return cell
    }
}

extension LeftMenuViewController: RESideMenuDelegate {
  
    func sideMenu(_ sideMenu: RESideMenu!, didRecognizePanGesture recognizer: UIPanGestureRecognizer!) {
        
    }
    
    
    func sideMenu(_ sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
        
    }
    
    
    func sideMenu(_ sideMenu: RESideMenu!, didShowMenuViewController menuViewController: UIViewController!) {
        
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, willHideMenuViewController menuViewController: UIViewController!) {
        
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, didHideMenuViewController menuViewController: UIViewController!) {
        
    }
}
