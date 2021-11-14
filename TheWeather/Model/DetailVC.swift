//
//  DetailVC.swift
//  TheWeather
//
//  Created by admin on 11/14/21.
//

import UIKit
import SwiftSVG

class DetailVC: UIViewController {

    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var minTempLable: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var weatherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshLabels()
    
    }
    
    func refreshLabels() {
        nameCityLabel.text = weatherModel?.name
        guard let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weatherModel!.conditionCode).svg") else { return }
        
        let weatherImage = UIView(SVGURL: url) {(image) in
            image.resizeToFit(self.viewCity.bounds)
        }
        self.viewCity.addSubview(weatherImage)
        
        conditionLabel.text = weatherModel?.conditionString
        tempCityLabel.text  = weatherModel?.temperatureString
        pressureLabel.text  = "\((weatherModel?.pressureMm)!)"
        windSpeedLabel.text = "\((weatherModel?.windSpeed)!)"
        minTempLable.text   = "\((weatherModel?.tempMin)!)"
        maxTempLabel.text   = "\((weatherModel?.tempMax)!)"
    }

}
