//
//  Weather.swift
//  TheWeather
//
//  Created by admin on 11/14/21.
//

import Foundation

struct Weather {
    var name: String = "Название"
    var temperature: Double = 0.0
    var temperatureString: String { return String(format: "%.0f", temperature)}
    var conditionCode: String = ""
    var url: String = ""
    var condition: String = ""
    var pressureMm: Int = 0
    var windSpeed: Double = 0.0
    var tempMin: Int = 0
    var tempMax: Int = 0
    
    var conditionString: String {
        switch condition {
        case "clear" :                  return "Ясно"
        case "partly-cloudy" :          return "Малооблачно"
        case "cloudy" :                 return "Облачно с прояснениями"
        case "overcast" :               return "Пасмурно"
        case "drizzle" :                return "Морось"
        case "light-rain" :             return "Небольшой дождь"
        case "rain" :                   return "Дождь"
        case "moderate-rain" :          return "Умеренно сильный дождь"
        case "heavy-rain" :             return "Сильный дождь"
        case "continuous-heavy-rain" :  return "Длительный сильный дождь"
        case "showers" :                return "Ливень"
        case "wet-snow" :               return "Дождь со снегом"
        case "light-snow" :             return "Небольшой снег"
        case "snow" :                   return "Снег"
        case "snow-showers" :           return "Снегопад"
        case "hail" :                   return "Град"
        case "thunderstorm" :           return "Гроза"
        case "thunderstorm-with-rain" : return "Дождь с грозой"
        case "thunderstorm-with-hail" : return "Гроза с градом"
        default:                        return "Загрузка..."
            
        }
    }
    
    init?(weatherModel: WeatherModel) {
        temperature = weatherModel.fact.temp
        conditionCode = weatherModel.fact.icon
        url = weatherModel.info.url
        condition = weatherModel.fact.condition
        pressureMm = weatherModel.fact.pressureMm
        windSpeed = weatherModel.fact.windSpeed
        tempMin = weatherModel.forecasts.first!.parts.day.tempMin!
        tempMax = weatherModel.forecasts.first!.parts.day.tempMax!
    }
    init() {
    }
}
