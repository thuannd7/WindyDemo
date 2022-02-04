//
//  HomeLocationTableViewCell.swift
//  WeatherDemo
//
//  Created by admin2 on 1/22/22.
//

import UIKit
import MGSwipeTableCell

class HomeLocationTableViewCell: MGSwipeTableCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var imvWeather: UIImageView!
    @IBOutlet weak var imvWind: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func billData(_ location: LocationModel, _ data: ForecastWeatherDataModel?) {
        lblName.text = location.name
        
        if let current = data?.current {
            lblWindSpeed.text = String(format: "%.1fm/s %@", current.wind_speed, current.wind_deg.windDegSymbol)
            imvWind.transform = CGAffineTransform(rotationAngle:  CGFloat(current.wind_deg*(Double.pi/180)))
            lblTemp.text = String(format: "%.0f °C", current.temp.tempK2C)
        } else {
            lblWindSpeed.text = "-"
            lblTemp.text = "-"
        }
        
        if let icon = data?.current.weather.first?.icon, !icon.isEmpty {
            imvWeather.image = UIImage(named: icon)
        } else {
            imvWeather.image = nil
        }
    }
}
