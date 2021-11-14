//
//  GetCityWeather.swift
//  TheWeather
//
//  Created by admin on 11/14/21.
//

import Foundation
import CoreLocation

let networkWeatherManager = NetworkWeatherManager()

func getCityWeather(cityArray: [String], completionHandler: @escaping (Int, Weather) -> Void) {
    
    for (index, item) in cityArray.enumerated() {
        
        getCoordinate(city: item) { (coordinate, error  )in
            guard let coordinate = coordinate, error == nil else { return }
            networkWeatherManager.performRequest(latitude: coordinate.latitude, longitude: coordinate.longitude) { (weather) in
                completionHandler(index, weather)
            }
            
        }
    }
}

func getCoordinate(city: String, complition: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) ->() ) {
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        complition(placemark?.first?.location?.coordinate, error)
    }
}
