//
//  BaseNavigationViewController.swift
//  WeatherDemo
//
//  Created by admin2 on 1/22/22.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.isOpaque = true
        self.delegate = self
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: TAppFont.font(weight: .regular, size: 17.0),
                                                  NSAttributedString.Key.foregroundColor: UIColor.black]
        
        self.navigationBar.tintColor    = AppColor.mainColor
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.shadowImage  = UIImage()
        
        self.interactivePopGestureRecognizer?.isEnabled = true
        self.interactivePopGestureRecognizer?.delegate = self
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.isOpaque = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent 
    }
}

extension BaseNavigationViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let currentVC = self.topViewController {
            let itemBack = UIBarButtonItem(title: "", style: .done, target: currentVC, action: nil)
            currentVC.navigationItem.backBarButtonItem = itemBack
        }
    }
}

extension BaseNavigationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}

extension UIColor {
    func as1ptImage() -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        self.setFill()
        ctx.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
