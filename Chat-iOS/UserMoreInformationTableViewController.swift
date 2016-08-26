//
//  UserMoreInformationTableViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/26.
//  Copyright © 2016年 xiaolei. All rights reserved.
//

import UIKit

class UserMoreInformationTableViewController: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 3
        default:
            return 1
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            sectionOne(indxPath: indexPath)
        case 1:
            sectionTwo(indxPath: indexPath)
        default:
            sectionThree(indxPath: indexPath)
        }
    }
    
    
    func sectionThree(indxPath:IndexPath) {
        
    }
    
    func sectionTwo(indxPath:IndexPath) {
        switch indxPath.row {
        case 0:
            break
        case 1:
            break
        default:
            break
        }
    }
    
    func sectionOne(indxPath:IndexPath) {
        switch indxPath.row {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        default:
            break
        }
    }
}
