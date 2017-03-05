//
//  SKHomeHeaderView.swift
//  Shark
//
//  Created by Dalang on 2017/3/5.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit

let TAG_DOWNLOADBUTTON = 100
let TAG_QUESTIONBUTTON = 102
let TAG_SHARKBUTTON = 103
let TAG_TOOLBUTTON = 104

/// 主页的TableHeaderView
final class SKHomeHeaderView: UIView {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
}

// MARK: - Private Method
extension SKHomeHeaderView {
    
    /// 初始化界面
    func setup() {
        
    }
    
    // MARK: Properties
    /// 下载按钮
    var downloadButton: UIButton {
        let button = creteButton(forTitle: "下载", image: UIImage(named: "home_bg_download"), selector: #selector(buttonPressed(_:)))
        button.tag = TAG_DOWNLOADBUTTON
        return button
    }
    
    /// 问题按钮
    var questionButton: UIButton {
        let button = creteButton(forTitle: "问题", image: UIImage(named: "home_bg_question"), selector: #selector(buttonPressed(_:)))
        button.tag = TAG_QUESTIONBUTTON
        return button
    }
    
    /// 鲨小白按钮
    var sharkButton: UIButton {
        let button = creteButton(forTitle: "鲨小白", image: UIImage(named: "home_bg_shark"), selector: #selector(buttonPressed(_:)))
        button.tag = TAG_SHARKBUTTON
        return button
    }
    
    /// 工具箱按钮
    var toolButton: UIButton {
        let button = creteButton(forTitle: "工具箱", image: UIImage(named: "home_bg_tool"), selector: #selector(buttonPressed(_:)))
        button.tag = TAG_TOOLBUTTON
        return button
    }
    
    /// 推荐阅读
    var suggestedReadingView: UIView {
        let baseView: UIView = UIView()
        baseView.backgroundColor = UIColor.clear
        
        let view: UIView = UIView()
        view.backgroundColor = UIColor.mainBlue
        baseView.addSubview(view)
        
        view.snp.makeConstraints { (maker) in
            maker.left.equalTo(baseView.snp.left).offset(8)
            maker.height.equalTo(19)
            maker.width.equalTo(2)
            maker.centerY.equalTo(baseView.snp.centerY)
        }
        
        let label: UILabel = UILabel()
        label.text = "推荐阅读"
        label.textColor = UIColor(hexString: "#666666")
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = UIColor.clear
        baseView.addSubview(label)
        
        label.snp.makeConstraints { (maker) in
            maker.left.equalTo(view.snp.right).offset(8)
            maker.right.equalTo(baseView.snp.right).offset(-8)
            maker.top.bottom.equalTo(0)
        }
        
        return baseView
    }
    
    /// 生成按钮
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - image: 图片
    ///   - selector: 方法
    /// - Returns: UIButton
    func creteButton(forTitle title: String, image: UIImage?, selector: Selector) -> UIButton {
        let button: UIButton = UIButton.init(type: .custom)
        button.backgroundColor = UIColor.white
        button.set(image: image, title: title, titlePosition: .bottom, spacing: 10, forState: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    func buttonPressed(_ button: UIButton) {
        
    }
    
    
    
}
