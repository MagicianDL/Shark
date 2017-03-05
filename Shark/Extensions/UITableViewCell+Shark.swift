//
//  UITableViewCell+Shark.swift
//  Shark
//
//  Created by Dalang on 2017/3/3.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    /// Cell identifier
    class var identifier: String {
        return String(describing: self)
    }
    
    /// nib
    class var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}
