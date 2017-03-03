//
//  UIColor+Shark.swift
//  Shark
//
//  Created by Dalang on 2017/3/2.
//  Copyright © 2017年 青岛鲨鱼汇信息技术有限公司. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var mainBlue: UIColor {
        return UIColor(hexString: "#3E71A0")
    }
    
    class var mainGray: UIColor {
        return UIColor(hexString: "#F2F2F2")
    }
    
    class var random: UIColor {
        let red = CGFloat(arc4random_uniform(256))
        let green = CGFloat(arc4random_uniform(256))
        let blue = CGFloat(arc4random_uniform(256))
        let alpha = CGFloat(arc4random_uniform(256))
        
        return UIColor(r: red, g: green, b: blue, a: alpha)
    }
    
    
}

// MARK: Hex
extension UIColor {
    
    /// 通过32位整型创建颜色
    ///
    /// - Parameter hex: UInt32
    convenience init(hex: UInt32) {
        let mask = 0x000000FF
        
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    /// 通过32位整型字符串创建颜色
    ///
    /// - Parameter hexString: UInt32 字符串
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            self.init(hex: color)
        } else {
            self.init(hex: 0x000000)
        }
    }
    
    
    /// 颜色 -> UInt32
    ///
    /// - Returns: UInt32
    final func toHex() -> UInt32 {        
        let rgba: RGBA = toRGBAComponents()
        let colorToUInt32 = roundToHex(rgba.r) << 16 | roundToHex(rgba.g) << 8 | roundToHex(rgba.b)
        
        return colorToUInt32
    }
    
    
    /// 颜色 -> UInt32 String
    ///
    /// - Returns: UInt32 String
    final func toHexString() -> String {
        return String(format:"#%06x", toHex())
    }
    
}

// MARK: RGBA
extension UIColor {
    
    typealias RGBA = (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)
    
    /// 通过rgba初始化
    ///
    /// - Parameters:
    ///   - r: 0 ~ 255
    ///   - g: 0 ~ 255
    ///   - b: 0 ~ 255
    ///   - a: 0 ~ 255， 默认 255
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 255) {
        self.init(red: clip(r, 0, 255) / 255, green: clip(g, 0, 255) / 255, blue: clip(b, 0, 255) / 255, alpha: clip(a, 0, 255) / 255)
    }
    
    /// 获取 rgba 属性
    ///
    /// - Returns: RGBA
    final func toRGBAComponents() -> RGBA {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
    
    
    /// R 属性
    final var redComponent: CGFloat {
        return self.toRGBAComponents().r
    }
    
    /// G 属性
    final var greenComponent: CGFloat {
        return self.toRGBAComponents().g
    }
    
    /// B 属性
    final var blueComponent: CGFloat {
        return self.toRGBAComponents().b
    }
    
    /// A 属性
    final var alphaComponent: CGFloat {
        return self.toRGBAComponents().a
    }
    
}

// MARK: Utils

func clip<T: Comparable>(_ v: T, _ minimum: T, _ maximum: T) -> T {
    return max(min(v, maximum), minimum)
}

func roundToHex(_ x: CGFloat) -> UInt32 {
    return UInt32(round(1000 * x) / 1000 * 255)
}
