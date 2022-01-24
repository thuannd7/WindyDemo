//
//  StoreHelper.swift
//  BaseLife
//
//  Created by iMac on 1/14/20.
//  Copyright © 2020 BaseLife. All rights reserved.
//

import UIKit
import StoreKit
import SDWebImage

class TAppHelper: NSObject {
    
    static func rateApp() {
        let appId = "1502054514"
        
        if let url = URL(string: "itms-apps://itunes.apple.com/app/" + appId) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    static func feedback() {
        let urlStr = "https://docs.google.com/spreadsheets/d/1mX2yvzhfsHfev1z0iYFYVcmm0cfudOS0Ib-wSChQYIQ/edit?usp=sharing"
        if let url = URL(string: urlStr) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    static func contactUs() {
        let urlStr = "https://www.facebook.com/Money-Note-112364990386152"
        if let url = URL(string: urlStr) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    static func shareApp(_ controller: UIViewController, _ position: CGRect) {
        let urlStr = "itms-apps://itunes.apple.com/app/1502054514"
        
        if let url = URL(string: urlStr) {
            let items = ["Money Note", url] as [Any]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            
            if isIphoneApp() {
                controller.present(ac, animated: true)
            } else {
                if let popOver = ac.popoverPresentationController {
                    popOver.sourceView = controller.view
                    popOver.sourceRect = position
                    popOver.permittedArrowDirections = .any
                    controller.present(ac, animated: true)
                }
            }
        }
    }
    
    static func shareURL(_ url: URL, _ controller: UIViewController, _ position: CGRect) {
        let items = ["Money Note", url] as [Any]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        if isIphoneApp() {
            controller.present(ac, animated: true)
        } else {
            if let popOver = ac.popoverPresentationController {
                popOver.sourceView = controller.view
                popOver.sourceRect = position
                popOver.permittedArrowDirections = .any
                controller.present(ac, animated: true)
            }
        }
    }
    
    static var appVersion: String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let version = appVersion ?? ""
        return "Version \(version) (\(buildNumber))"
    }
    
    private static var buildNumber: String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        return appVersion ?? ""
    }
    
    class func shareMediaURL(fromVC: UIViewController, title: String?, videoUrl: String?, imageURL: String, sender: UIView?) {
        DispatchQueue.global(qos: .background).async {
            var activityItems: [Any] = []
            
            if let videoUrl = videoUrl, let url = URL(string: videoUrl) {
                activityItems.append(url)
            }
            
            if let image = URL(string: imageURL) {
                activityItems.append(image)
            }
            
            if let title = title {
                activityItems.append(title)
            }
            
            DispatchQueue.main.async {
                let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: [])
                vc.completionWithItemsHandler = { activity, success, items, error in
                    if error != nil {
                        TToast.showToastWithMessage("Lỗi")
                    } else if success {
                        TToast.showToastWithMessage("Đã chia sẻ")
                    }
                }
                
                if let popOver = vc.popoverPresentationController {
                    popOver.sourceView = sender ?? fromVC.view
                    popOver.permittedArrowDirections = .any
                    fromVC.modalPresentationStyle = .popover
                }
                
                fromVC.present(vc, animated: true, completion: nil)
            }
        }
    }
        
    class func saveImageWithURLString(_ imageURL: String) {
        if let image = SDImageCache.shared().imageFromDiskCache(forKey: imageURL) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
        
    class func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
        
    @objc class private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            TToast.showToastWithMessage(error.localizedDescription)
        } else {
            TToast.showToastWithMessage("Đã lưu")
        }
    }
}
