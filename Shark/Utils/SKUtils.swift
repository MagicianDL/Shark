//
//  SKUtils.swift
//  Shark
//
//  Created by Dalang on 2017/3/3.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//


/// 常用方法
import UIKit

class SKUtils: NSObject {

    class func initializeAppDefaultSetting() {
        initializeNavigationBar()
        initializeTabbar()
    }
    
    /// tabbar 设置
    class func initializeTabbar() {
        
        let normalAttributes: Dictionary = [
            NSForegroundColorAttributeName: UIColor(hexString: "#A9A8A8")
        ]
        
        let selectedAttribute: Dictionary = [
            NSForegroundColorAttributeName: UIColor.mainBlue
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: UIControlState.normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttribute, for: UIControlState.selected)
        UITabBar.appearance().tintColor = UIColor.mainBlue
        
    }
    
    /// 导航栏设置
    class func initializeNavigationBar() {
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor.mainBlue,
            NSFontAttributeName: UIFont.systemFont(ofSize: 20)
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().tintColor = UIColor.mainBlue
    }
    
}
