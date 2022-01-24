//
//  UIViewExtension.swift
//  Utils
//
//  Created by Macintosh on 9/19/18.
//  Copyright © 2018 Macintosh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func initWithDefaultNib() -> Self {
        return initWithNibTemplate()
    }
    
    private class func initWithNibTemplate<T>() -> T {
        let nibName = String(describing: self)
        let view = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first
        return view as! T
    }
    
    class func nib() -> UINib {
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: nil)
    }
}
