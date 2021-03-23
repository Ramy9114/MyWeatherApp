//
//  CitiesTableUseCases.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 10/03/2021.
//

import Foundation

protocol WeatherDetailUseCasesProtocol: class {
    func executeGetCurrentWeather(cityName: String?, completion:
                                    @escaping (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void)
}

final class WeatherDetailUseCases {

    // MARK: - Private variables
    private let weatherDetailRepository: WeatherDetailRepositoryProtocol?
//
    // MARK: - Initialization
    init(weatherDetailRepository: WeatherDetailRepositoryProtocol) {
        self.weatherDetailRepository = weatherDetailRepository
    }

}

// MARK: - Execute functions
extension WeatherDetailUseCases: WeatherDetailUseCasesProtocol {
    func executeGetCurrentWeather(cityName: String?, completion:
                                    @escaping  (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void) {
        weatherDetailRepository?.fetchCurrentWeather(cityName: cityName, completion: { (weather, status, message) in
            if status {
                guard let weather = weather else {return}
                completion(weather, true, message)
            } else {
                completion(nil, false, message)
            }
        })
    }
}
