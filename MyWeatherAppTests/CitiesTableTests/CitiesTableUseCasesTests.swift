//
//  CitiesTableUseCasesTests.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 18/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import MyWeatherApp

// MARK: - CitiesTableUseCasesMock
class CitiesTableUseCasesMock: CitiesTableUseCasesProtocol {
    func executeSaveCity(cityName: String) -> CoreDataError? {
        return .none
    }
    
    func executeCheckIfCityExists(cityName: String) -> CoreDataError? {
        return .none
    }
    
    func executeDeleteCity(cityName: String) {
        
    }
    
    func executeGetCities() -> [CityItem]? {
        return []
    }
    
    var executeSaveCity: CityItem?
    var executeSaveCityCoreDataError: CoreDataError?
    func executeSaveCity(cityItem: CityItem) -> CoreDataError? {
        executeSaveCity = cityItem
        return executeSaveCityCoreDataError
    }
    
    func executeDeleteCity(item: CityItem) {

    }
    
    var executeGetCity: String?
    var executeGetWeatherModelMock: WeatherModel?
    var executeGetAlertUserString: String?
    
    func executeGetCity(cityName: String, completion: @escaping (WeatherModel?, Bool, String) -> Void) {
        executeGetCity = cityName
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.executeGetWeatherModelMock, true, "")
        }
    }
}
