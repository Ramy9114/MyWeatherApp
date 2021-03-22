//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 12/03/2021.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
