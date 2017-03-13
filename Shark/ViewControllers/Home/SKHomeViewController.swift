//
//  SKHomeViewController.swift
//  Shark
//
//  Created by Dalang on 2017/3/2.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit


/// 导航栏高度增加量
let NAVIGATIONBAR_HEIGHT_INCREMENT = CGFloat(0)

class SKHomeViewController: SKBaseViewController {

    // MARK: - Properties
    
    /// Articles
    fileprivate lazy var articles: Array = {
        return Array<Any>()
    } ()
    /// tableView
    fileprivate lazy var tableView: UITableView = {
        
        let tableView                   = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor       = UIColor.mainGray
        tableView.delegate              = self
        tableView.dataSource            = self
        tableView.separatorStyle        = .none
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(77, 0, 0, 0);
        tableView.register(SKArticleTableViewCell.self, forCellReuseIdentifier: SKArticleTableViewCell.identifier)
        
        return tableView
    } ()
    
    /// TableHeaderView
    fileprivate lazy var tableHeaderView: SKHomeHeaderView = {
        let header = SKHomeHeaderView(frame: CGRect(x: 0, y: 0, width: SK_SCREEN_WIDTH, height: 344.0))
    
        return header
    } ()

    /// Menu
    fileprivate lazy var menuView: SKHomeMenuView = {
        let menu = SKHomeMenuView()
        
        return menu
    } ()
    
    fileprivate lazy var titleView: SKHomeTitleView = {
        let titleView = SKHomeTitleView(frame: CGRect(x: 0, y: 0, width: SK_SCREEN_WIDTH, height: 44 + NAVIGATIONBAR_HEIGHT_INCREMENT))
    
        return titleView
    } ()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.titleView = titleView
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(0, for: .default)
        
        self.view.addSubview(tableView)
        
        tableView.tableHeaderView = tableHeaderView
        
        self.view.addSubview(menuView)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)) { [unowned self] in
            self.tableHeaderView.reload()
        }
        
        UIRefreshControl
        
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navigationBar = self.navigationController?.navigationBar else {
            return
        }
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.mainBlue
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let navigationBar = self.navigationController?.navigationBar else {
            return
        }
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = nil
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.shadowImage = nil

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        guard let navigationBar = self.navigationController?.navigationBar else {
            return
        }
        
        var navigationBarFrame: CGRect = navigationBar.frame
        navigationBarFrame.size.height = navigationBarFrame.size.height + NAVIGATIONBAR_HEIGHT_INCREMENT
        navigationBar.frame            = navigationBarFrame
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Private Method
extension SKHomeViewController {
    
    /// 布局
    fileprivate func layout() {
        
        tableView.snp.makeConstraints { (maker) in
            
            maker.left.equalTo(self.view.snp.left)
            maker.top.equalTo(topLayoutGuide.snp.bottom).offset(NAVIGATIONBAR_HEIGHT_INCREMENT)
            maker.right.equalTo(self.view.snp.right)
            maker.bottom.equalTo(bottomLayoutGuide.snp.top)
            
        }
        
        menuView.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.view.snp.left)
            maker.top.equalTo(topLayoutGuide.snp.bottom).offset(NAVIGATIONBAR_HEIGHT_INCREMENT)
            maker.right.equalTo(self.view.snp.right)
            maker.height.equalTo(77)
        }
        
    }
    
    /// 处理MenuView透明度
    ///
    /// - Parameter offset: TableView Y 方向上的偏移量
    fileprivate func handleMenuView(withOffset offset: CGFloat) {
        
        titleView.handleAlpha(withOffset: offset)
        menuView.handleAlpha(withOffset: offset)
        
    }
}

// MARK: - UITableViewDelegate
extension SKHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("TableView did select row at \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SKArticleTableViewCell.cellHeight
    }
    
}

// MARK: - UITableViewDataSource
extension SKHomeViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell: SKArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: SKArticleTableViewCell.identifier) as! SKArticleTableViewCell
        
        cell.confiureCell()
        
        return cell
        
    }
}

// MARK: - UIScrollViewDelegate
extension SKHomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView as! UITableView) === self.tableView {
            let offsetY = scrollView.contentOffset.y
            
            handleMenuView(withOffset: offsetY)
            
            if offsetY >= 0 {
                menuView.snp.updateConstraints({ (maker) in
                    maker.top.equalTo(topLayoutGuide.snp.bottom).offset(-offsetY + NAVIGATIONBAR_HEIGHT_INCREMENT)
                })
            } else {
                menuView.snp.updateConstraints({ (maker) in
                    maker.top.equalTo(topLayoutGuide.snp.bottom).offset(NAVIGATIONBAR_HEIGHT_INCREMENT)
                })
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView as! UITableView) === self.tableView {
            let offsetY = scrollView.contentOffset.y
            if offsetY >= 0 && offsetY < CGFloat(77) / 2.0  {
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            } else if offsetY >= CGFloat(77) / 2.0 && offsetY < CGFloat(77) {
                scrollView.setContentOffset(CGPoint(x: 0, y: 77), animated: true)
            }
        }
    }
    
}



