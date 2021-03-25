//
//  AddCityFormUseCasesTests.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 24/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import MyWeatherApp

// MARK: - AddCityFormUseCasesMock
class AddCityFormUseCasesMock: CitiesTableUseCasesProtocol {
    func executeGetCities() -> [CityItem]? {
        //modify this later
        return []
    }
    
    func executeSaveCity(cityName: String) -> CoreDataError? {
        return .none
    }
    
    func executeGetCity(cityName: String, completion: @escaping (WeatherModel?, Bool, String) -> Void) {
        completion(nil, true, "")
    }
    
    func executeDeleteCity(cityName: String) {
        
    }
    
    // Current UseCase Implementation
    var executeCheckIfCityExistsErrorResponse: CoreDataError?
    
    func executeCheckIfCityExists(cityName: String) -> CoreDataError? {
        return executeCheckIfCityExistsErrorResponse
    }
    
}
