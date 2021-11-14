//
//  NetworkWeatherManager.swift
//  TheWeather
//
//  Created by admin on 11/14/21.
//

import Foundation


struct NetworkWeatherManager {

    func performRequest(latitude: Double, longitude: Double, completionHandler: @escaping (Weather) -> Void) {
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
        
        guard let url = URL(string: urlString) else { return}
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("\(apiKey)", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        print(request)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }

            if let weather = self.parseJSON(with: data){
                completionHandler(weather)
            }
        }
        .resume()
    }
    func parseJSON(with data: Data) ->Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherModel.self, from: data)
            guard let weather = Weather(weatherModel: weatherData) else {
                return nil
            }
            return weather
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
