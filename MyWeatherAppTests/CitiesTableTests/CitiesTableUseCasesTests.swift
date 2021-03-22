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
    func executeGetCities() -> [CityItem]? {
        return nil
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
    func executeGetCity(name: String, completion: @escaping (WeatherModel?, Bool, String) -> Void) {
        executeGetCity = name
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.executeGetWeatherModelMock, true, "")
        }
    }
}
