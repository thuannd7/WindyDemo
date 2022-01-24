//
//  DoubleExtension.swift
//  WeatherDemo
//
//  Created by Thuan Nguyen on 24/01/2022.
//

import UIKit

extension Double {
    var tempK2C: Double {
        let temp_K = 273.15
        return self - temp_K
    }
    
    var windDegSymbol: String {
        let deg = self
        var degSymbol = ""
        
        if deg == 0 {
            degSymbol = "N"
        } else if deg > 0 && deg < 45 {
            degSymbol = "NNE"
        } else if deg == 45 {
            degSymbol = "NE"
        } else if deg > 45 && deg < 90 {
            degSymbol = "ENE"
        } else if deg == 90 {
            degSymbol = "E"
        } else if deg > 90 && deg < 135 {
            degSymbol = "ESE"
        } else if deg == 135 {
            degSymbol = "SE"
        } else if deg > 135 && deg < 180 {
            degSymbol = "SSE"
        } else if deg == 180 {
            degSymbol = "S"
        } else if deg > 180 && deg < 225 {
            degSymbol = "SSW"
        } else if deg == 225 {
            degSymbol = "SW"
        } else if deg > 225 && deg < 270 {
            degSymbol = "WSW"
        } else if deg == 270 {
            degSymbol = "W"
        } else if deg > 270 && deg < 315 {
            degSymbol = "WW"
        } else if deg == 315 {
            degSymbol = "NW"
        } else if deg > 315 && deg < 360 {
            degSymbol = "NNW"
        } else {
            degSymbol = "N"
        }
        
        return degSymbol
    }
}
