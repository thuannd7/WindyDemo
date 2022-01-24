//
//  TToast.swift
//  Utils
//
//  Created by Macintosh on 9/28/18.
//  Copyright © 2018 Macintosh. All rights reserved.
//

import UIKit
import Toast

class TToast: NSObject {
    class func showToastWithMessage(_ message: String?) {
        guard let message = message else {
            return
        }
        
        if let window = UIApplication.shared.keyWindow {
            window.hideAllToasts()
            
            let style = CSToastStyle(defaultStyle: ())
            CSToastManager.setSharedStyle(style)
            CSToastManager.setTapToDismissEnabled(true)
            CSToastManager.setQueueEnabled(true)
            
            window.makeToast(message, duration: 1.5, position: CSToastPositionCenter, style: style)
        }
    }
}
