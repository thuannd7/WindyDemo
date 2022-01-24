//
//  UITableViewExtension.swift
//  Utils
//
//  Created by Macintosh on 9/23/18.
//  Copyright © 2018 Macintosh. All rights reserved.
//

import UIKit

extension UITableView {
    func doSetTableViewFooterReset() {
        self.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func doSetTableViewHeaderReset() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        view.backgroundColor = .white
        self.tableHeaderView = view
    }
    
    func doReloadData() {
        self.reloadData()
    }
}
