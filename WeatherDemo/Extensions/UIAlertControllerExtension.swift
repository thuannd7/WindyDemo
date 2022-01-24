//
//  UIAlertControllerExtension.swift
//  Utils
//
//  Created by iMac on 3/6/20.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func controller(title: String?, message: String?) -> UIAlertController {
        let interface = UIDevice.current.userInterfaceIdiom
        let preferredStyle: UIAlertController.Style = interface == .pad ? .alert : .actionSheet
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: preferredStyle)
        
        alert.overrideUserInterfaceStyle = .dark
        return alert
    }
    
    class func controller(title: String?, message: String?, style: UIAlertController.Style) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: style)
        
        alert.overrideUserInterfaceStyle = .dark
        return alert
    }
}
