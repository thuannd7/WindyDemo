//
//  LocationModel.swift
//  WeatherDemo
//
//  Created by admin2 on 1/22/22.
//

import UIKit
import SwiftyJSON

class LocationModel: NSObject {
    var id: String = ""
    var name: String = ""
    var state: String = ""
    var country: String = ""
    var lat: Double = 0.0
    var long: Double = 0.0
    var searchStr: String = ""
    
    init(dict: NSDictionary) {
        id      = dict.stringValueWithKey("id")
        name    = dict.stringValueWithKey("name")
        state   = dict.stringValueWithKey("state")
        country = dict.stringValueWithKey("country")
        lat     = dict.doubleValueWithKey("coord.lat")
        long    = dict.doubleValueWithKey("coord.lon")
        searchStr = name.searchString
    }
    
    init(json: JSON) {
        id      = json["id"].stringValue
        name    = json["name"].stringValue
        state   = json["state"].stringValue
        country = json["country"].stringValue
        lat     = json["coord"]["lat"].doubleValue
        long    = json["coord"]["lon"].doubleValue
        searchStr = name.searchString
    }
    
    var isInFavorite: Bool {
        return DataManager.shared.isInFavorite(self)
    }
}
