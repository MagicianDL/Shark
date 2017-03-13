//
//  SKCarouselCellInfo.swift
//  CarouselDemo
//
//  Created by Dalang on 2017/3/6.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit

final class SKCarouselCellInfo: NSObject {
    
    /// 页面滚动时间
    let showTime: UInt
    /// 图片名字
    let imageName: String
    
    class func carouselCellInfo(withDictionary dic: Dictionary<String, Any>) -> SKCarouselCellInfo {
        return SKCarouselCellInfo(withDictionary: dic)
    }

    init(withDictionary dic: Dictionary<String, Any>) {
        
        showTime = dic["showTime"] as! UInt
        imageName = dic["imageName"] as! String
        
        super.init()
    }
    
}
