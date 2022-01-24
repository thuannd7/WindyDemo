//
//  UIImageViewExtension.swift
//  Utils
//
//  Created by Macintosh on 10/12/18.
//  Copyright © 2018 Macintosh. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func kSetImageWithURLStr(_ str: String?) {
        guard let urlStr = str else {
            self.image = nil
            self.backgroundColor = AppColor.backgroundImageColor
            return
        }
        let url = URL(string: urlStr)
        self.sd_setImage(with: url, completed: nil)
    }
    
    func kSetImageWithURL(_ url: URL?) {
        self.sd_setImage(with: url, completed: nil)
    }
    
    func setImageTemplate(name: String) {
        let image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
        self.image = image
        self.tintColor = AppColor.mainColor
    }
}
