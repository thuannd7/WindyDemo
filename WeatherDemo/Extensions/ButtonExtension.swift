//
//  ButtonExtension.swift
//  Utils
//
//  Created by Macintosh on 3/6/20.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit

enum UIButtonMode {
    case gray
    case green
    case red
    case none
    
    var backgroundColor: UIColor {
        if self == .gray {
            return UIColor.lightGray
        }
        
        if self == .green {
            return UIColor.green
        }
        
        if self == .red {
            return UIColor.red
        }
        
        return UIColor.clear
    }
    
    var titleColor: UIColor {
        if self == .none {
            return UIColor.black
        }
        
        return UIColor.white
    }
}

extension UIButton {
    func setButtonMode(_ mode: UIButtonMode) {
        self.backgroundColor = mode.backgroundColor
    }
    
//    func setButtonOn(_ isOn: Bool) {
//        if isOn {
//            self.backgroundColor = UIButtonMode.green.backgroundColor
//            self.setTitleColor(.white, for: .normal)
//        } else {
//            self.backgroundColor = .clear
//            self.setTitleColor(theme.subTitleColor, for: .normal)
//        }
//    }
    
    func setButtonOn(_ isOn: Bool, onMode: UIButtonMode, offMode: UIButtonMode) {
        if isOn {
            self.backgroundColor = onMode.backgroundColor
            self.setTitleColor(offMode.titleColor, for: .normal)
        } else {
            self.backgroundColor = offMode.backgroundColor
            self.setTitleColor(offMode.titleColor, for: .normal)
        }
    }
}
