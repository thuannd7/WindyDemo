//
//  LocationDetailViewController.swift
//  WeatherDemo
//
//  Created by admin2 on 1/22/22.
//

import UIKit
import WebKit
import MapKit

class LocationDetailViewController: BaseViewController {

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblUV: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblDewPoint: UILabel!
    @IBOutlet weak var lblVisibility: UILabel!
    @IBOutlet weak var imvWeather: UIImageView!
    @IBOutlet weak var lblWeatherDesc: UILabel!
    @IBOutlet weak var imvCurrentLocation: UIImageView!
    @IBOutlet weak var imvWind: UIImageView!
    
    var locationName: String?
    var data: ForecastWeatherDataModel?
    var isCurrentLocation: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        renderMap()
    }

    //MARK:- IBACTIONS
    @IBAction func btnClosePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- METHODS
    func setUpView() {
        lblUV.text = "UV index: -"
        imvCurrentLocation.isHidden = !isCurrentLocation
        
        guard let data = data?.current else {
            lblLocationName.text = "Current Location"
            lblTemp.text = "-"
            lblWind.text = "Wind: -"
            lblHumidity.text = "Humidity: -"
            lblPressure.text = "Pressure: -"
            lblVisibility.text = "Visibility: -"
            lblDewPoint.text = "Dew point: -"
            lblWeatherDesc.text = ""
            imvWeather.image = nil
            imvWind.isHidden = true
            lblLocationName.text = "-"
            lblUV.text = "UV index: -"
            return
        }
        
        imvWind.isHidden = false
        imvWind.transform = CGAffineTransform(rotationAngle: CGFloat(data.wind_deg*(Double.pi/180)))
        DLog("windInfor.deg: \(data.wind_deg)")
        
        lblLocationName.text = locationName?.capitalized
        lblTemp.text = String(format: "%.0f°C", data.temp.tempK2C)
        lblWind.text = String(format: "Wind: %.1fm/s %@", data.wind_speed, data.wind_deg.windDegSymbol)
        lblHumidity.text = "Humidity: \(Int(data.humidity))%"
        
        lblPressure.text = "Pressure: \(Int(data.pressure))hPa"
        lblVisibility.text = String(format: "Visibility: %.1fkm", data.visibility/1000)
        lblDewPoint.text = String(format: "Dew point: %.0f°C", data.dew_point.tempK2C)
        lblUV.text = "UV index: \(data.uvi)"
        
        let weather = data.weather.first
        lblWeatherDesc.text = weather?.desc.capitalizingFirstLetter()
        
        if let icon = weather?.icon, !icon.isEmpty {
            imvWeather.image = UIImage(named: icon)
        } else {
            imvWeather.image = nil
        }
    }
    
    func renderMap() {
//        In here will load map for windy, using API purchase Developer 140 GBP/ month,
//        but I don't have API key PRO, i will display image for demo idea.
//        guard let lat = data?.lat, let long =  data?.long else {
//            return
//        }
//        let isMapProMode = false
//        let layer = "wind_new"
//        let zoom = "5"
//        let apiKey = WeatherService.API_KEY
//        let date = Date().millisecondsSince1970/1000
//        var urlStr = ""
//
//        if isMapProMode {
//            urlStr = "http://maps.openweathermap.org/maps/2.0/weather/WND/\(zoom)/\(lat)/\(long)?date=\(date)&appid=\(apiKey)"
//        } else {
//            urlStr = "https://tile.openweathermap.org/map/\(layer)/\(zoom)/\(Int(lat))/\(Int(long)).png?appid=\(apiKey)"
//        }
//
//        DLog("urlStr: \(urlStr)")
//
//        guard let url = URL(string: urlStr) else {
//            return
//        }
//
//        let request = URLRequest(url: url)
//        webView.load(request)
    }
}
