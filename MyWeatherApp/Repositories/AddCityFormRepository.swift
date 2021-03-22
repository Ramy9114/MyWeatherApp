//
//  AddCityFormRepository.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 22/03/2021.
//

import Foundation

protocol AddCityFormRepositoryProtocol: class {
    
}

final class AddCityFormRepository {
    
    var callBack: WeatherCallBack?

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
    
}
