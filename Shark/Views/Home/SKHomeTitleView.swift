//
//  SKHomeTitleView.swift
//  Shark
//
//  Created by Dalang on 2017/3/10.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit

fileprivate let TAG_HOMETITLEVIEW_LEGALINSPECTION    = 100
fileprivate let TAG_HOMETITLEVIEW_MARRIAGEINSPECTION = 101
fileprivate let TAG_HOMETITLEVIEW_SEARCHBUTTON       = 102
fileprivate let TAG_HOMETITLEVIEW_SEARCHVIEW         = 103
fileprivate let TAG_HOMETITLEVIEW_NOTIFICATION       = 104

class SKHomeTitleView: UIView {

    // MARK: - Properties
    
    /// 鲨鱼汇logo
    lazy fileprivate var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home_titleView_syh")
        return imageView
    }()
    
    /// 法人体检按钮
    lazy fileprivate var legalInspectionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = TAG_HOMETITLEVIEW_LEGALINSPECTION
        button.setImage(UIImage(named: "home_button_legalInspection"), for: .normal)
        button.addTarget(self, action: #selector(clickAction(_:)), for: .touchUpInside)
        return button
    }()
    
    /// 婚姻计算器按钮
    lazy fileprivate var marriageInspectionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = TAG_HOMETITLEVIEW_MARRIAGEINSPECTION
        button.setImage(UIImage(named: "home_button_marriageInspection"), for: .normal)
        button.addTarget(self, action: #selector(clickAction(_:)), for: .touchUpInside)
        return button
    }()
    
    /// 搜索按钮
    lazy fileprivate var searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = TAG_HOMETITLEVIEW_SEARCHBUTTON
        button.setImage(UIImage(named: "nav_search_white"), for: .normal)
        button.addTarget(self, action: #selector(clickAction(_:)), for: .touchUpInside)
        return button
    }()
    
    /// 通知按钮
    lazy var notificationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = TAG_HOMETITLEVIEW_NOTIFICATION
        button.setImage(UIImage(named: "nav_notification"), for: .normal)
        button.addTarget(self, action: #selector(clickAction(_:)), for: .touchUpInside)
        return button
    } ()
    
    lazy fileprivate var searchView: UIView = {
        let view                = UIView()
        view.tag                = TAG_HOMETITLEVIEW_SEARCHVIEW
        view.layer.cornerRadius = 3
        view.backgroundColor    = UIColor(white: 0.8, alpha: 0.3)
        let tapGes              = UITapGestureRecognizer(target: self, action: #selector(clickAction(_:)))
        view.addGestureRecognizer(tapGes)

        
        let imageView         = UIImageView(image: UIImage(named: "nav_search_white"))
        imageView.contentMode = .center
        view.addSubview(imageView)
        
        
        imageView.snp.makeConstraints({ (maker) in
            maker.top.equalTo(view.snp.top).offset(4)
            maker.right.equalTo(view.snp.right).offset(-4)
            maker.bottom.equalTo(view.snp.bottom).offset(-4)
            maker.width.equalTo(imageView.snp.height)
        })
        
        
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
        
        if offset <= 0 {
            legalInspectionButton.alpha                       = 0
            legalInspectionButton.isUserInteractionEnabled    = false
            marriageInspectionButton.alpha                    = 0
            marriageInspectionButton.isUserInteractionEnabled = false
            searchButton.alpha                                = 0
            searchButton.isUserInteractionEnabled             = false
            searchView.alpha                                  = 1
            searchView.isUserInteractionEnabled               = true
        } else if offset > 0 && offset <= 77.0 / 2 {
            
            legalInspectionButton.alpha                       = 0
            legalInspectionButton.isUserInteractionEnabled    = false
            marriageInspectionButton.alpha                    = 0
            marriageInspectionButton.isUserInteractionEnabled = false
            searchButton.alpha                                = 0
            searchButton.isUserInteractionEnabled             = false
            
            searchView.alpha = 1 - 1.0 / (77.0 / 2) * offset
        } else if offset > 77.0 / 2 && offset <= 77 {
            searchView.alpha                                  = 0
            searchView.isUserInteractionEnabled               = false
            
            let alpha                      = 1.0 / (77.0 / 2) * (offset - 77.0 / 2)
            legalInspectionButton.alpha    = alpha
            marriageInspectionButton.alpha = alpha
            searchButton.alpha             = alpha
        } else if offset > 77 {
            searchView.alpha               = 0
            legalInspectionButton.alpha    = 1
            marriageInspectionButton.alpha = 1
            searchButton.alpha             = 1
        } else  {
            
        }        
    }
    
    
    
}

// MARK: - Private methods
extension SKHomeTitleView {
    
    /// 搭建界面
    fileprivate func setup() {
        
        self.backgroundColor = UIColor.mainBlue
        
        self.addSubview(logo)
        self.addSubview(legalInspectionButton)
        self.addSubview(marriageInspectionButton)
        self.addSubview(searchView)
        self.addSubview(searchButton)
        self.addSubview(notificationButton)
        
        legalInspectionButton.alpha                       = 0
        legalInspectionButton.isUserInteractionEnabled    = false
        marriageInspectionButton.alpha                    = 0
        marriageInspectionButton.isUserInteractionEnabled = false
        searchButton.alpha                                = 0
        searchButton.isUserInteractionEnabled             = false
        
    }
    
    /// 布局
    fileprivate func layout() {
        
        logo.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.width.equalTo(68)
            maker.height.equalTo(21)
            maker.centerY.equalTo(self.snp.centerY)
        }
        
        legalInspectionButton.snp.makeConstraints { (maker) in
            maker.left.equalTo(logo.snp.right).offset(8)
            maker.top.equalTo(self.snp.top)
            maker.bottom.equalTo(self.snp.bottom)
            maker.width.equalTo(20)
        }
        
        marriageInspectionButton.snp.makeConstraints { (maker) in
            maker.left.equalTo(legalInspectionButton.snp.right).offset(8)
            maker.top.equalTo(self.snp.top)
            maker.bottom.equalTo(self.snp.bottom)
            maker.width.equalTo(20)
        }
        
        notificationButton.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right)
            maker.top.equalTo(self.snp.top)
            maker.bottom.equalTo(self.snp.bottom)
            maker.width.equalTo(20)
        }
        
        searchButton.snp.makeConstraints { (maker) in
            maker.right.equalTo(notificationButton.snp.left).offset(-8)
            maker.top.equalTo(self.snp.top)
            maker.bottom.equalTo(self.snp.bottom)
            maker.width.equalTo(20)
        }
        
        searchView.snp.makeConstraints { (maker) in
            maker.left.equalTo(logo.snp.right).offset(8)
            maker.right.equalTo(notificationButton.snp.left).offset(-8)
            maker.top.equalTo(logo.snp.top)
            maker.bottom.equalTo(logo.snp.bottom)
        }
        
        
    }
    
    @objc fileprivate func clickAction(_ sender: Any) {
        
        var tag: Int? = 0
        if sender is UITapGestureRecognizer {
            tag = (sender as! UITapGestureRecognizer).view?.tag
        } else if sender is UIButton {
            tag = (sender as! UIButton).tag
        }
        
    }
    
    
    
    
    
}


