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
        // modify this later
        return []
    }
    
    func executeDeleteCity(cityName: String) {
        
    }
    
    // Current UseCase Implementation
    var executeCheckIfCityExistsErrorResponse: CoreDataError?
    func executeCheckIfCityExists(cityName: String) -> CoreDataError? {
        return executeCheckIfCityExistsErrorResponse
    }
    
    // UseCase of Weather API call
    var executeGetCityCalled = false
    var executeGetCityCityName: String?
    var executeGetCityWeatherModelMock: WeatherModel?
    var executeGetCityStatusMock: Bool?
    var executeGetCityMessageMock: String?
    func executeGetCity(cityName: String, completion: @escaping (WeatherModel?, Bool, String) -> Void) {
        executeGetCityCalled = true
        executeGetCityCityName = cityName
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.executeGetCityWeatherModelMock,
                       self.executeGetCityStatusMock ?? true,
                       self.executeGetCityMessageMock ?? "")
        }
    }
    
    var executeSaveCityCalled = false
    var executeSaveCityName: String?
    var executeSaveCityErrorResponse: CoreDataError?
    func executeSaveCity(cityName: String) -> CoreDataError? {
        executeSaveCityCalled = true
        executeSaveCityName = cityName
        return executeSaveCityErrorResponse
    }
    
}
