//
//  WeatherModel.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 12/03/2021.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var conditionName: String {
        switch conditionID {
        // Type No.1: Thunderstorm
        case 200...232:
            return "cloud.bolt"
        // Type No.2: Drizzle
        case 300...321:
            return "cloud.drizzle"
        // Type No.3: Rain
        case 500...531:
            return "cloud.rain"
        // Type No.4: Snow
        case 600...622:
            return "cloud.snow"
        // Type No.5: Atmosphere
        case 701...781:
            return "sun.haze.fill"
        // Type No.6: Clear
        case 800:
            return "sun.max"
        // Type No.7: Clouds
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
