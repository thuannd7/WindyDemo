//
//  TBaseNavigationItem.swift
//  Utils
//
//  Created by Macintosh on 9/20/18.
//  Copyright © 2018 Macintosh. All rights reserved.
//

import UIKit

enum AppNavigationItemStyle {
    case more
    case add
    case search
    case cancel
    case save
    case close
    case closeIcon
    case done
    case edit
    case remove
    case menu
}

class TBaseNavigationItem: UIBarButtonItem {
    
    class func itemWithStyle(style: AppNavigationItemStyle, target: AnyObject, sel: Selector) -> UIBarButtonItem {
        switch style {
        case .more:
            return self.itemWithImage(image: #imageLiteral(resourceName: "ic_more"), target: target, action: sel)
        case .add:
            return self.itemWithImage(image: #imageLiteral(resourceName: "ic_plus"), target: target, action: sel)
        case .search:
            return self.itemWithImage(image: #imageLiteral(resourceName: "ic_search"), target: target, action: sel)
        case .close:
            return self.itemWithTitle(title: "Close", target: target, action: sel)
        case .closeIcon:
            return self.itemWithImage(image: #imageLiteral(resourceName: "ic_close"), target: target, action: sel)
        case .cancel:
            return self.itemWithTitle(title: "Cancel", target: target, action: sel)
        case .save:
            return self.itemWithTitle(title: "Save", target: target, action: sel)
        case .done:
            return self.itemWithTitle(title: "Done", target: target, action: sel)
        case .edit:
            let image = UIImage(named: "ic_edit_white")
            return self.itemWithImage(image: image, target: target, action: sel)
        case .remove:
            let item = self.itemWithTitle(title: "Delete", target: target, action: sel)
            item.tintColor = AppColor.redColor
            return item
        case .menu:
            return self.itemWithImage(image: #imageLiteral(resourceName: "ic_menu"), target: target, action: sel)
        }
    }
    
    private static func itemWithTitle(title: String, target: AnyObject, action: Selector) -> UIBarButtonItem {
        let item = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        item.tintColor = AppColor.mainColor
        return item
    }
    
    private static func itemWithImage(image: UIImage?, target: AnyObject, action: Selector) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        item.tintColor = AppColor.mainColor
        return item
    }
    
    static func titleItem(_ title: String?) -> UIBarButtonItem {
        let label = UILabel(frame: CGRect.zero)
        label.text = title
        label.font = TAppFont.font(weight: .medium, size: 25.0)
        label.textColor = AppColor.mainColor
        label.sizeToFit()
        
        let item = UIBarButtonItem(customView: label)
        return item
    }
}
