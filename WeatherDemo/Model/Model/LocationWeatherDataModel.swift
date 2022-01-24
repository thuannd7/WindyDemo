//
//  LocationWeatherDataModel.swift
//  WeatherDemo
//
//  Created by admin2 on 1/22/22.
//

import UIKit
import SwiftyJSON

class LocationWeatherDataModel: NSObject {
    var id: Int = 0
    var timezone: Int = 0
    var visibility: Double = 0.0
    var dt: Double = 0.0
    var name: String = ""
    var lat: Double = 0.0
    var long: Double = 0.0
    var tempInfor: TempInfor
    var windInfor: WindInfor
    var sysInfor: SysInfor
    var weathers: [WeatherInfor] = []
    
    init(_ json: JSON) {
        id          = json["id"].intValue
        timezone    = json["timezone"].intValue
        visibility  = json["visibility"].doubleValue
        dt          = json["dt"].doubleValue
        name        = json["name"].stringValue
        lat         = json["coord"]["lat"].doubleValue
        long        = json["coord"]["lon"].doubleValue
        tempInfor   = TempInfor(json["main"])
        windInfor   = WindInfor(json["wind"])
        sysInfor    = SysInfor(json["sys"])
        
        for sub in json["weather"].arrayValue {
            weathers.append(WeatherInfor(sub))
        }
    }
}
