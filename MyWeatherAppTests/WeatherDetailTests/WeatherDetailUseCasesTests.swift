//
//  WeatherDetailUseCasesTests.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 18/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import MyWeatherApp

// MARK: - WeatherDetailUseCasesMock
class WeatherDetailUseCasesMock: WeatherDetailUseCasesProtocol {
    
    var executeGetCurrentWeatherCityName: String?
    var executeGetCurrentWeatherModelMock: WeatherModel?
    
    func executeGetCurrentWeather(cityName: String?, completion: @escaping (WeatherModel?, Bool, String) -> Void) {
        executeGetCurrentWeatherCityName = cityName
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.executeGetCurrentWeatherModelMock, true, "")
        }

    }
}
