//
//  JSONExtension.swift
//  ULife
//
//  Created by iMac on 7/30/20.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit
import SwiftyJSON

extension JSON {
    static func getJSONWithPath(_ path: String) -> JSON? {
           if let path = Bundle.main.path(forResource: path, ofType: "json") {
               do {
                   guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
                       let jsonObj = try? JSON(data: data) else {
                           return nil
                   }
                   
                   return jsonObj
               }
           }
           return nil
       }
    
    var itemsCount: Int {
        return self["itemsCount"].intValue
    }
    
    var data: [JSON] {
        return self["data"].arrayValue
    }
    
    var list: [JSON] {
        return self["list"].arrayValue
    }
    
    var page_index: Int {
        return self["page_index"].intValue
    }
    
    var per_page: Int {
        return self["per_page"].intValue
    }
    
    var total_item: Int {
        return self["total_item"].intValue
    }
}
