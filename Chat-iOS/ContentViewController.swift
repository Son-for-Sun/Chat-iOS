//
//  ContentViewController.swift
//  Chat-iOS
//
//  Created by xiaolei on 2016/8/25.
//  Copyright © 2016年 xiaolei. All rights reserved.
//  https://github.com/romaonthego/RESideMenu

import UIKit
import RESideMenu
class ContentViewController: RESideMenu {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.menuPreferredStatusBarStyle = UIStatusBarStyle.lightContent
        self.contentViewShadowColor = UIColor.black
        self.contentViewShadowOffset = CGSize(width: 0, height: 0)
        self.contentViewShadowOpacity = 0.6;
        self.contentViewShadowRadius = 12;
        self.contentViewShadowEnabled = true;
        
        self.contentViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootViewController")
        self.leftMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "LeftMenu")
        self.contentViewScaleValue = 2 / 3
        self.contentViewInLandscapeOffsetCenterX = 0
        self.contentViewInPortraitOffsetCenterX = 0
    }
}
