//
//  CitiesRepository.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 10/03/2021.
//

import Foundation

protocol CitiesRepositoryProtocol: class {
    func fetchCity(cityName: String, completion: @escaping  (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void)
    func fetchCityFromList(cityName: String) -> CoreDataError?
    func saveCity(cityName: String) -> CoreDataError?
    func getCities() -> [CityItem]?
    func deleteCity(cityName: String)
    
}

final class CitiesRepository {
    let coreDataManager: CoreDataManagerProtocol?
    let weatherService: WeatherServiceProtocol?

    init(coreDataManager: CoreDataManagerProtocol, weatherService: WeatherServiceProtocol) {
        self.coreDataManager = coreDataManager
        self.weatherService = weatherService
    }

    // MARK: - Execute functions
    
}

// MARK: - Execute functions
extension CitiesRepository: CitiesRepositoryProtocol {
    func fetchCityFromList(cityName: String) -> CoreDataError? {
        return coreDataManager?.checkCityFromCoreData(cityName: cityName)
    }
    
    func fetchCity(cityName: String, completion: @escaping  (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void) {
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

    func getCities() -> [CityItem]? {
        return coreDataManager?.getCities()
    }
    
    func deleteCity(cityName: String) {
        coreDataManager?.deleteCity(cityName: cityName)
    }
}
