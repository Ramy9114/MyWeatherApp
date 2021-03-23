//
//  WeatherDetailRepository.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 17/03/2021.
//

import Foundation

protocol WeatherDetailRepositoryProtocol: class {
    func fetchCurrentWeather(cityName: String?,
                             completion: @escaping(_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void)
}

final class WeatherDetailRepository {

    let weatherService: WeatherServiceProtocol?
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    // MARK: - Execute functions

}

// MARK: - Execute functions
extension WeatherDetailRepository: WeatherDetailRepositoryProtocol {
func fetchCurrentWeather(cityName: String?,
                         completion: @escaping(_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void) {
        weatherService?.fetchCurrentWeather(cityName: cityName, completion: { (weather, status, message) in
            if status {
                guard let weather = weather else {return}
                completion(weather, true, message)
            } else {
                completion(nil, false, message)
            }
        })
    }
}
