//
//  SKCarouselSubview.swift
//  CarouselDemo
//
//  Created by Dalang on 2017/3/6.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit


// MARK: 容器
final class SKCarouselSubview: UIView {

    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        return containerView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView.frame = CGRect(x: 2, y: 0, width: frame.width - 4, height: frame.height)
        self.addSubview(containerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: cell基类
 class SKCarouselCell: UIView {
    
    var showTime: TimeInterval = 0
    
}

final class SKCarouselCellImageView: SKCarouselCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .center
        return imageView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.frame = self.bounds
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
