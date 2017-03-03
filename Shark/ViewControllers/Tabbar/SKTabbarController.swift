//
//  SKTabbarController.swift
//  Shark
//
//  Created by Dalang on 2017/3/2.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit

class SKTabbarController: UITabBarController {
    
    /// 主页
    lazy var homeViewController: SKHomeViewController = {

        let home = SKHomeViewController()
        home.title = "主页"
        
        let normalImage = UIImage(named: "tabbar_home_unsel")
        let selectedImage = UIImage(named: "tabbar_home_sel")
        home.tabBarItem = UITabBarItem(title: "主页", image: normalImage, selectedImage: selectedImage)
        
        return home
    
    } ()
    
    /// 报告
    lazy var reportViewController: SKReportViewController = {
        
        let report = SKReportViewController()
        report.title = "报告"
        
        let normalImage = UIImage(named: "tabbar_report_unsel")
        let selectedImage = UIImage(named: "tabbar_report_sel")
        report.tabBarItem = UITabBarItem(title: "报告", image: normalImage, selectedImage: selectedImage)
        
        return report
        
    } ()
    
    /// 服务
    lazy var conversationViewController: SKConversationViewController = {
    
        let conversation = SKConversationViewController()
        conversation.title = "服务"
        
        let normalImage = UIImage(named: "tabbar_message_unsel")
        let selectedImage = UIImage(named: "tabbar_message_sel")
        conversation.tabBarItem = UITabBarItem(title: "服务", image: normalImage, selectedImage: selectedImage)
        
        return conversation
    
    } ()
    
    lazy var mineViewController: SKMineViewController = {
    
        let mine = SKMineViewController()
        mine.title = "我的"
        
        let normalImage = UIImage(named: "tabbar_mine_unsel")
        let selectedImage = UIImage(named: "tabbar_mine_sel")
        mine.tabBarItem = UITabBarItem(title: "我的", image: normalImage, selectedImage: selectedImage)
        
        return mine
        
    } ()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.mainGray
        
        self.viewControllers = [
            SKBaseNavigationController(rootViewController: self.homeViewController),
            SKBaseNavigationController(rootViewController: self.reportViewController),
            SKBaseNavigationController(rootViewController: self.conversationViewController),
            SKBaseNavigationController(rootViewController: self.mineViewController)
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: 
extension SKTabbarController {
    
    
}
