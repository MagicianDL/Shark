//
//  UIButton+Shark.swift
//  Shark
//
//  Created by Dalang on 2017/3/5.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit


// MARK: - Title Position
extension UIButton {
    
    enum UIButtonTitlePosition {
        case top
        case bottom
        case left
        case right
    }
    
    func set(image anImage: UIImage?, title: String?, titlePosition: UIButtonTitlePosition, spacing: CGFloat, forState state: UIControlState) {
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        lablePositionRespectToImage(title: title, position: titlePosition, spacing: spacing)
    }
    
    
    private func lablePositionRespectToImage(title: String?, position: UIButtonTitlePosition, spacing: CGFloat) {
        if let title_ = title {
            let imageSize = self.imageRect(forContentRect: self.frame)
            let titleFont = self.titleLabel?.font!
            let titleSize = title_.size(attributes: [NSFontAttributeName: titleFont!])
            
            var titleInsets: UIEdgeInsets
            var imageInsets: UIEdgeInsets
            
            switch position {
            case .top:
                titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
                imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            case .bottom:
                titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
                imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            case .left:
                titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
                imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
            case .right:
                titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
                imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                //        default:
                //            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                //            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            
            self.titleEdgeInsets = titleInsets
            self.imageEdgeInsets = imageInsets

        }
        
    }
}
