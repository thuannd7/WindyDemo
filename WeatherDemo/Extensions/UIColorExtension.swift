//
//  UIColorExtension.swift
//  Utils
//
//  Created by Macintosh on 5/31/20.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit

extension UIColor {
//    static func hexColor (hex: String) -> UIColor {
//        let r, g, b : CGFloat
//
//        if hex.hasPrefix("#") {
//            let start = hex.index(hex.startIndex, offsetBy: 1)
//            let hexColor = String(hex[start...])
//
//            let scanner = Scanner(string: hexColor)
//            var hexNumber: UInt64 = 0
//
//            if scanner.scanHexInt64(&hexNumber) {
//                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
//                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
//                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
////                a = CGFloat(hexNumber & 0x000000ff) / 255
//                return UIColor(red: r, green: g, blue: b, alpha: 1.0)
//            }
//        }
//
//        return UIColor.clear
//    }
    
    static func hexColor(_ hexString: String, _ alpha: CGFloat = 1.0)-> UIColor {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return  UIColor(red:red, green:green, blue:blue, alpha:alpha)
    }
    
     func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
