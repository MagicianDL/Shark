//
//  SKHomeViewController.swift
//  Shark
//
//  Created by Dalang on 2017/3/2.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit

class SKHomeViewController: SKBaseViewController {

    // MARK: Properties
    
    /// Articles
    lazy var articles: Array = {
        return Array<Any>()
    } ()
    /// tableView
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.mainGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(SKArticleTableViewCell.self, forCellReuseIdentifier: SKArticleTableViewCell.identifier)
        
        return tableView
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        self.view.addSubview(tableView)
        
        layout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: Private Method
extension SKHomeViewController {
    
    func layout() {
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
    }
    
    
}

// MARK: UITableViewDelegate
extension SKHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("TableView did select row at \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SKArticleTableViewCell.cellHeight
    }
    
}
// Mark: UITableViewDataSource
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
