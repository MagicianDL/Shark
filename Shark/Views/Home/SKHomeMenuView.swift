//
//  SKHomeMenuView.swift
//  Shark
//
//  Created by Dalang on 2017/3/10.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit

fileprivate let TAG_HOMEMENUVIEW_LEGALINSPECTION    = 100
fileprivate let TAG_HOMEMENUVIEW_MARRIAGEINSPECTION = 110

final class SKHomeMenuView: UIView {

    // MARK: Private properties
    
    /// Legal Inspection Menu
    lazy var legalInspectionView: UIView = {
        let view   = SKHomeMenuView.menu("法人体检", withDescription: "专注人力资源风险诊断", andMenuLogo: UIImage(named: "home_bg_legalInspection"))
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(menuTapAction(_:)))
        view.tag   = TAG_HOMEMENUVIEW_LEGALINSPECTION
        view.addGestureRecognizer(tapGes)
        return view
    } ()
    
    
    /// Marriage Inspection Menu
    lazy var marriageInspectionView: UIView = {
        let view   = SKHomeMenuView.menu("婚姻计算器", withDescription: "多一点理智 少一点冲动", andMenuLogo: UIImage(named: "home_bg_marriageCheck"))
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(menuTapAction(_:)))
        view.tag   = TAG_HOMEMENUVIEW_MARRIAGEINSPECTION
        view.addGestureRecognizer(tapGes)
        
        return view
    }()
    
    lazy var dividingLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    } ()
    
    // MARK: Initialized method
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }

    /// 处理各Subview的透明度
    ///
    /// - Parameter offset: 偏移量
    func handleAlpha(withOffset offset: CGFloat) {
        
        if offset <= 0  {
            legalInspectionView.alpha    = 1
            marriageInspectionView.alpha = 1
            dividingLine.alpha           = 1
        } else if offset > 0 && offset < 77.0 / 2.0 {
            let alpha                    = 1.0 - 1.0 / (77.0 / 2.0) * offset
            legalInspectionView.alpha    = alpha
            marriageInspectionView.alpha = alpha
            dividingLine.alpha           = alpha
        } else if offset == 77.0 / 2.0 {
            legalInspectionView.alpha    = 0
            marriageInspectionView.alpha = 0
            dividingLine.alpha           = 0
        } else {
            
        }
    }

    
    
    
}

extension SKHomeMenuView {
    
    
    /// 界面设置
    fileprivate func setup() {
        
        self.backgroundColor = UIColor.mainBlue
        
        self.addSubview(legalInspectionView)
        self.addSubview(dividingLine)
        self.addSubview(marriageInspectionView)
    }
    
    /// 界面布局
    fileprivate func layout() {
        
        dividingLine.snp.makeConstraints { (maker) in
            maker.width.equalTo(1)
            maker.height.equalTo(25)
            maker.center.equalTo(self)
        }
        
        legalInspectionView.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.top.equalTo(self.snp.top)
            maker.bottom.equalTo(self.snp.bottom)
            maker.right.equalTo(dividingLine.snp.left)
        }
        
        marriageInspectionView.snp.makeConstraints { (maker) in
            maker.left.equalTo(dividingLine.snp.right)
            maker.top.equalTo(self.snp.top)
            maker.bottom.equalTo(self.snp.bottom)
            maker.right.equalTo(self.snp.right)
        }
        
    }
    
    /// 创建菜单
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - description: 副标题
    ///   - logo: 图片
    /// - Returns: UIView
    fileprivate class func menu(_ title: String, withDescription description: String, andMenuLogo logo: UIImage?) -> UIView {
        
        let baseView = UIView()
        baseView.backgroundColor = UIColor.clear
        
        let imageView         = UIImageView()
        imageView.contentMode = .center
        imageView.image       = logo
        baseView.addSubview(imageView)
        
        let titleLabel       = UILabel()
        titleLabel.font      = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.white
        titleLabel.text      = title
        baseView.addSubview(titleLabel)
        
        let descriptionLabel       = UILabel()
        descriptionLabel.font      = UIFont.systemFont(ofSize: 11)
        descriptionLabel.textColor = UIColor(hexString: "#B7C6D7")
        descriptionLabel.text      = description
        baseView.addSubview(descriptionLabel)
        
        imageView.snp.makeConstraints { (maker) in
            maker.left.equalTo(baseView.snp.left)
            maker.top.equalTo(baseView.snp.top)
            maker.bottom.equalTo(baseView.snp.bottom)
            maker.width.equalTo(55)
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(imageView.snp.right)
            maker.top.equalTo(baseView.snp.top).offset(20)
            maker.right.equalTo(baseView.snp.right)
        }
        
        descriptionLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(imageView.snp.right)
            maker.bottom.equalTo(baseView.snp.bottom).offset(-20)
            maker.right.equalTo(baseView.snp.right)
        }
        
        return baseView;
    }
    
    /// Menu 点击事件
    ///
    /// - Parameter tapGes: UITapGestureRecognizer
    @objc fileprivate func menuTapAction(_ tapGes: UITapGestureRecognizer) {
        
    }
    
    
}
