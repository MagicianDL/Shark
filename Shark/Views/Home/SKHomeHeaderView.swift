//
//  SKHomeHeaderView.swift
//  Shark
//
//  Created by Dalang on 2017/3/5.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit

fileprivate let TAG_HOMEHEADERVIEW_DOWNLOADBUTTON = 100
fileprivate let TAG_HOMEHEADERVIEW_QUESTIONBUTTON = 102
fileprivate let TAG_HOMEHEADERVIEW_SHARKBUTTON    = 103
fileprivate let TAG_HOMEHEADERVIEW_TOOLBUTTON     = 104

/// 主页的TableHeaderView
final class SKHomeHeaderView: UIView {
    
    // MARK: Properties
    
//    fileprivate lazy var cellInfoArray: [SKCarouselCellInfo] = {
//        
//        let array: Array = (NSArray(contentsOfFile: Bundle.main.path(forResource: "imageInfos", ofType: "plist")!)! as Array)
//        
//        var cellInfoArray = [SKCarouselCellInfo]()
//        
//        for index in 0..<array.count {
//            let dic = array[index] as! [String: Any]
//            let cellInfo = SKCarouselCellInfo(withDictionary: dic)
//            cellInfoArray.append(cellInfo)
//        }
//        
//        return cellInfoArray
//    }()

    var cellInfoArray: [SKCarouselCellInfo] = [SKCarouselCellInfo]()
    
    
    fileprivate lazy var carouselView: SKCarouselView = {
        let carouselView = SKCarouselView(frame: CGRect.zero, dataSource: self, delegate: self)
        
        return carouselView
    } ()
    
    /// 下载按钮
    fileprivate lazy var downloadButton: UIButton = {
        let button: UIButton    = UIButton.init(type: .custom)
        button.backgroundColor  = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.tag              = TAG_HOMEHEADERVIEW_DOWNLOADBUTTON
        button.setTitleColor(UIColor(hexString: "#666666"), for: .normal)
        button.set(image: UIImage(named: "home_bg_download"), title: "下载", imagePosition: .top, spacing: 10, forState: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    } ()
    
    /// 问题按钮
    fileprivate lazy var questionButton: UIButton = {
        let button: UIButton    = UIButton.init(type: .custom)
        button.backgroundColor  = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.tag              = TAG_HOMEHEADERVIEW_QUESTIONBUTTON
        button.setTitleColor(UIColor(hexString: "#666666"), for: .normal)
        button.set(image: UIImage(named: "home_bg_question"), title: "问题", imagePosition: .top, spacing: 10, forState: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    } ()
    
    /// 鲨小白按钮
    fileprivate lazy var sharkButton: UIButton = {
        let button: UIButton    = UIButton.init(type: .custom)
        button.backgroundColor  = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.tag              = TAG_HOMEHEADERVIEW_SHARKBUTTON
        button.setTitleColor(UIColor(hexString: "#666666"), for: .normal)
        button.set(image: UIImage(named: "home_bg_shark"), title: "鲨小白", imagePosition: .top, spacing: 10, forState: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    } ()
    
    /// 工具箱按钮
    fileprivate lazy var toolButton: UIButton = {
        let button: UIButton    = UIButton.init(type: .custom)
        button.backgroundColor  = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.tag              = TAG_HOMEHEADERVIEW_TOOLBUTTON
        button.setTitleColor(UIColor(hexString: "#666666"), for: .normal)
        button.set(image: UIImage(named: "home_bg_tools"), title: "工具箱", imagePosition: .top, spacing: 10, forState: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    } ()
    
    /// 推荐阅读
    fileprivate lazy var suggestedReadingView: UIView = {
       
        let baseView: UIView     = UIView()
        baseView.backgroundColor = UIColor.clear
        
        let view: UIView     = UIView()
        view.backgroundColor = UIColor.mainBlue
        baseView.addSubview(view)
        
        let label: UILabel    = UILabel()
        label.text            = "推荐阅读"
        label.textColor       = UIColor(hexString: "#666666")
        label.font            = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = UIColor.clear
        baseView.addSubview(label)
        
        view.snp.makeConstraints { (maker) in
            maker.left.equalTo(baseView.snp.left).offset(8)
            maker.height.equalTo(19)
            maker.width.equalTo(2)
            maker.centerY.equalTo(baseView.snp.centerY)
        }
        
        label.snp.makeConstraints { (maker) in
            maker.left.equalTo(view.snp.right).offset(8)
            maker.top.equalTo(baseView.snp.top)
            maker.bottom.equalTo(baseView.snp.bottom)
        }
        
        return baseView
    } ()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    func reload() {
        
        let array: Array = (NSArray(contentsOfFile: Bundle.main.path(forResource: "imageInfos", ofType: "plist")!)! as Array)
        
        
        for index in 0..<array.count {
            let dic      = array[index] as! [String: Any]
            let cellInfo = SKCarouselCellInfo(withDictionary: dic)
            cellInfoArray.append(cellInfo)
        }
        

        
        carouselView.reloadData()
    }
    
}

// MARK: - Private Method
extension SKHomeHeaderView {
    
    /// 初始化界面
    fileprivate func setup() {
        
        self.addSubview(suggestedReadingView)
        self.addSubview(downloadButton)
        self.addSubview(questionButton)
        self.addSubview(sharkButton)
        self.addSubview(toolButton)
        self.addSubview(carouselView)
        
        
    }
    
    /// 布局
    fileprivate func layout() {
        
        suggestedReadingView.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(self.snp.right)
            maker.bottom.equalTo(self.snp.bottom)
            maker.height.equalTo(39)
        }
        
        downloadButton.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.bottom.equalTo(suggestedReadingView.snp.top)
            maker.height.equalTo(86)
            maker.width.equalTo(self.snp.width).multipliedBy(0.25)
        }
        
        questionButton.snp.makeConstraints { (maker) in
            maker.left.equalTo(downloadButton.snp.right)
            maker.top.equalTo(downloadButton.snp.top)
            maker.bottom.equalTo(downloadButton.snp.bottom)
            maker.width.equalTo(downloadButton.snp.width)
        }
        
        sharkButton.snp.makeConstraints { (maker) in
            maker.left.equalTo(questionButton.snp.right)
            maker.top.equalTo(downloadButton.snp.top)
            maker.bottom.equalTo(downloadButton.snp.bottom)
            maker.width.equalTo(downloadButton.snp.width)
        }
        
        toolButton.snp.makeConstraints { (maker) in
            maker.left.equalTo(sharkButton.snp.right)
            maker.top.equalTo(downloadButton.snp.top)
            maker.bottom.equalTo(downloadButton.snp.bottom)
            maker.width.equalTo(downloadButton.snp.width)
        }
        
        carouselView.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.snp.left)
            maker.right.equalTo(self.snp.right)
            maker.bottom.equalTo(downloadButton.snp.top).offset(-5)
            maker.height.equalTo(130)

        }
        
    }
    
    /// 点击按钮
    ///
    /// - Parameter button: UIButton
    @objc fileprivate func buttonPressed(_ button: UIButton) {
        
    }
}

// MARK: - SKCarouselViewDelegate SKCarouselViewDataSource
extension SKHomeHeaderView: SKCarouselViewDelegate, SKCarouselViewDataSource {
    func sizeForPage(inCarouselView carouselView: SKCarouselView) -> CGSize {
        return CGSize(width: 253, height: 130)
    }
    
    func numberOfPages(inCarouselView carouselView: SKCarouselView) -> Int {
        return cellInfoArray.count
    }
    
    func carouselView(_ carouselView: SKCarouselView, cellForPageAtIndex index: Int) -> SKCarouselCell {
        let cell             = SKCarouselCellImageView(frame: CGRect(x: 0, y: 0, width: 253 - 4, height: 130))
        let cellInfo         = cellInfoArray[index]
        cell.imageView.image = UIImage(named: cellInfo.imageName)
        cell.showTime        = TimeInterval(cellInfo.showTime)
        
        return cell
    }
    
    func carouselView(_ carouselView: SKCarouselView, didScrollToPage page: Int) {
//        print("didScrollToPage \(page)")
    }
    
    func carouselView(_ carouselView: SKCarouselView, didSelectPageAtIndex index: Int) {
//        print("didSelectPageAtIndex \(index)")
    }

}


