//
//  AddCityFormRepository.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 22/03/2021.
//

import Foundation

protocol AddCityFormRepositoryProtocol: class {
    func fetchCityFromCoreData(cityName: String) -> CoreDataError?
    func fetchCity(cityName: String, completion: @escaping  (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void)
    func saveCity(cityName: String) -> CoreDataError?
}

final class AddCityFormRepository {
    
    let coreDataManager: CoreDataManagerProtocol?
    let weatherService: WeatherServiceProtocol?

    init(coreDataManager: CoreDataManagerProtocol, weatherService: WeatherServiceProtocol) {
        self.coreDataManager = coreDataManager
        self.weatherService = weatherService
    }

    // MARK: - Execute functions
    
}

// MARK: - Execute functions
extension AddCityFormRepository: AddCityFormRepositoryProtocol {
    
    func fetchCityFromCoreData(cityName: String) -> CoreDataError? {
        return coreDataManager?.checkCityFromCoreData(cityName: cityName)
    }
    
    func fetchCity(cityName: String, completion: @escaping (WeatherModel?, Bool, String) -> Void) {
        weatherService?.fetchCurrentWeather(cityName: cityName, completion: { (weather, status, message) in
            if status {
                guard let weather = weather else {return}
                completion(weather, true, message)
            } else {
                completion(nil, false, message)
            }
        })
    }
    
    func saveCity(cityName: String) -> CoreDataError? {
        return coreDataManager?.saveCity(cityName: cityName)
    }
    
}
