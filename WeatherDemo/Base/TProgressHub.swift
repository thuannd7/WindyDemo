//
//  TProgressHub.swift
//  Utils
//
//  Created by Macintosh on 9/28/18.
//  Copyright © 2018 Macintosh. All rights reserved.
//

import UIKit
import SVProgressHUD
import MBProgressHUD

class TProgressHub: NSObject {
    class func show(_ view: UIView?) {
        guard let view = view else {
            return
        }
        
        DispatchQueue.main.async {
//            SVProgressHUD.show(withStatus: nil)
            MBProgressHUD.showAdded(to: view, animated: true)
        }
    }
    
    class func showProgressWithStr(_ str: String?) {
        SVProgressHUD.show(withStatus: str)
    }
    
    class func hide(_ view: UIView?) {
        guard let view = view else {
            return
        }
        DispatchQueue.main.async {
//            SVProgressHUD.dismiss(withDelay: 0.5)
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
    
    class func showErrWithStr(_ str: String?) {
        TToast.showToastWithMessage(str)
//        SVProgressHUD.showError(withStatus: str)
    }
    
    class func showError(_ err: Error?) {
        TToast.showToastWithMessage(err?.localizedDescription)
//        SVProgressHUD.showError(withStatus: err?.localizedDescription)
    }
}
