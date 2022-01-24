//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by admin2 on 1/22/22.
//

import UIKit
import SwiftyJSON

class WeatherService: APIBaseRequestService {
    static let API_KEY = "08869d29f8e15af55cd59f0a6127b31f"
    let API_BASE_URL = "http://api.openweathermap.org/data/2.5"
    let provider = APIRequestDataProvider()
    
    func getWeatherCurrentLocation(lat: String,
                                   long: String,
                                   complete:@escaping((_ data: LocationWeatherDataModel) -> Void),
                                   failse: @escaping((_ err: Error) -> Void)) {
        let params: [String: String] = ["lat": lat,
                                        "lon": long,
                                        "appid": WeatherService.API_KEY]
        
        let request = provider.requestWithParams(baseURL: API_BASE_URL,
                                                 apiURL: "/weather",
                                                 params: params,
                                                 method: .GET,
                                                 bodyDataType: .QuerryString)
        sendRequest(request) { (json: JSON) in
            let res = LocationWeatherDataModel(json)
            complete(res)
        } _: { (err: Error) in
            DLog("err: \(err)")
            failse(err)
        }
    }
    
    func getForecastWeatherOfLocation(lat: String,
                                      long: String,
                                      complete:@escaping((_ data: ForecastWeatherDataModel) -> Void),
                                      failse: @escaping((_ err: Error) -> Void)) {
        let params: [String: String] = ["lat": lat,
                                        "lon": long,
                                        "appid": WeatherService.API_KEY]
        
        let request = provider.requestWithParams(baseURL: API_BASE_URL,
                                                 apiURL: "/onecall",
                                                 params: params,
                                                 method: .GET,
                                                 bodyDataType: .QuerryString)
        sendRequest(request) { (json: JSON) in
            let res = ForecastWeatherDataModel(json)
            complete(res)
        } _: { (err: Error) in
            DLog("err: \(err)")
            failse(err)
        }
    }
}
