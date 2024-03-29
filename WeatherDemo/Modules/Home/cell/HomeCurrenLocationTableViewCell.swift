//
//  HomeCurrenLocationTableViewCell.swift
//  WeatherDemo
//
//  Created by admin2 on 1/22/22.
//

import UIKit
import CoreLocation

class HomeCurrenLocationTableViewCell: UITableViewCell {

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
    @IBOutlet weak var viewPermission: UIView!
    @IBOutlet weak var lblPermission: UILabel!
    @IBOutlet weak var btnOpenSetting: UIButton!
    @IBOutlet weak var imvWind: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnOpenSetingPressed(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            //app-settings:root=Privacy&path=LOCATION
            //app-settings:root=LOCATION_SERVICES
            if let url = URL(string: "app-settings:root=LOCATION_SERVICES") {
                UIApplication.shared.open(url)
            }
        } else {
            if let url = URL(string:UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func billData(_ location: LocationWeatherDataModel?, _ _data: ForecastWeatherDataModel?, status: CLAuthorizationStatus) {
        if CLLocationManager.locationServicesEnabled() {
            switch status {
            case .notDetermined:
                viewPermission.isHidden = false
                lblPermission.text = "Confirm use Location serivce to continue"
                btnOpenSetting.isHidden = true
                break
            case .denied, .restricted:
                viewPermission.isHidden = false
                lblPermission.text = "You denied Location service"
                btnOpenSetting.isHidden = false
                break
            default:
                viewPermission.isHidden = true
                break
            }
        } else {
            lblPermission.text = "Location service not enable\nTo use, please access Settings -> Privacy -> Location Services"
            viewPermission.isHidden = false
            btnOpenSetting.isHidden = false
        }
        
        guard let data = _data else {
            lblLocationName.text = "Current Location"
            lblTemp.text = "-"
            lblWind.text = "Wind: -"
            lblHumidity.text = "Humidity: -"
            lblPressure.text = "Pressure: -"
            lblVisibility.text = "Visibility: -"
            lblDewPoint.text = "Dew point: -"
            lblWeatherDesc.text = ""
            imvWeather.image = nil
            lblUV.text = "UV index: -"
            return
        }
        
        imvWind.transform = CGAffineTransform(rotationAngle:  CGFloat(data.current.wind_deg*(Double.pi/180)))
        lblLocationName.text = location?.name.capitalized
        lblTemp.text = String(format: "%.0f°C", data.current.temp.tempK2C)
        lblWind.text = String(format: "Wind: %.1fm/s %@", data.current.wind_speed, data.current.wind_speed.windDegSymbol)
        lblHumidity.text = "Humidity: \(Int(data.current.humidity))%"
        
        lblPressure.text = "Pressure: \(Int(data.current.pressure))hPa"
        lblVisibility.text = String(format: "Visibility: %.1fkm", data.current.visibility/1000)
        lblDewPoint.text = String(format: "Dew point: %.0f°C", data.current.dew_point.tempK2C)
        lblUV.text = "UV index: \(data.current.uvi)"
        
        let weather = data.current.weather.first
        lblWeatherDesc.text = weather?.desc.capitalizingFirstLetter()
        
        if let icon = weather?.icon, !icon.isEmpty {
            imvWeather.image = UIImage(named: icon)
        } else {
            imvWeather.image = nil
        }
    }
}
