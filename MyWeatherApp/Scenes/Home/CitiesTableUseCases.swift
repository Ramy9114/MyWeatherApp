//
//  CitiesTableUseCases.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 10/03/2021.
//

import Foundation

protocol CitiesTableUseCasesProtocol: class {
    func executeGetCities() -> [CityItem]?
    func executeSaveCity(cityName: String) -> CoreDataError?
    func executeGetCity(cityName: String, completion: @escaping (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void)
    func executeCheckIfCityExists(cityName: String) -> CoreDataError?
    func executeDeleteCity(cityName: String)
}

final class CitiesTableUseCases {

    // MARK: - Private variables
    private let citiesRepository: CitiesRepositoryProtocol?
//
    // MARK: - Initialization
    init(citiesRepository: CitiesRepositoryProtocol) {
        self.citiesRepository = citiesRepository
    }

}

// MARK: - Execute functions
extension CitiesTableUseCases: CitiesTableUseCasesProtocol {
    
    func executeCheckIfCityExists(cityName: String) -> CoreDataError? {
        return citiesRepository?.fetchCityFromCoreData(cityName: cityName)
    }
    
    func executeGetCity(cityName: String, completion: @escaping (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void) {
        // Step 1: get the required city's weather
        citiesRepository?.fetchCity(cityName: cityName, completion: { (weather, status, message) in
            if status {
                guard let weather = weather else {return}
                completion(weather, true, message)
            } else {
                completion(nil, false, message)
            }
        })
    }
    
    func executeSaveCity(cityName: String) -> CoreDataError? {
        return citiesRepository?.saveCity(cityName: cityName)
    }
    
    func executeGetCities() -> [CityItem]? {
        return citiesRepository?.getCities()
    }
    
    func executeDeleteCity(cityName: String) {
        citiesRepository?.deleteCity(cityName: cityName)
    }
}
