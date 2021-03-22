//
//  WeatherDetailViewModelTests.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 18/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import MyWeatherApp

class WeatherDetailViewModelMock: WeatherDetailViewModelProtocol {
    func bindToView(view: WeatherDetailViewProtocol) {
        
    }
    
    func getCurrentWeather(cityName: String?) {
        
    }
    
    func completionHandler(callBack: @escaping weatherCallBack) {
        
    }
    

    var bindToViewCalled: Bool = false
    func bindToView(view: WeatherDetailViewModelProtocol) {
        bindToViewCalled = true
    }

    // var methodResult: String?
    // var methodCalled: Bool = false
    // func method() -> String? {
    //     methodCalled = true
    //     return methodResult = "string"
    // }
    //
    // var asyncMethodResult: Result<SomeData?, SomeClassError>!
    // func asyncMethod(completion: @escaping (Result<SomeData?, SomeClassError>) -> Void) {
    //     completion(asyncMethodResult)
    // }
}

class WeatherDetailViewModelTests: XCTestCase {
    var viewControllerMock: WeatherDetailViewControllerMock!
    var useCasesMock: WeatherDetailUseCasesMock!
    var viewModel: WeatherDetailViewModel!

    override func setUp() {
        super.setUp()
        viewControllerMock = WeatherDetailViewControllerMock()
        useCasesMock = WeatherDetailUseCasesMock()
        viewModel = WeatherDetailViewModel(useCases: useCasesMock)
        viewModel.view = viewControllerMock
    }

    override func tearDown() {
        viewControllerMock = nil
        useCasesMock = nil
        viewModel = nil
        super.tearDown()
    }

    func testBindToView() {
        // Given
        let viewModel = WeatherDetailViewModel(useCases: useCasesMock)
        let viewControllerMock = WeatherDetailViewControllerMock()

        // When
        viewModel.bindToView(view: viewControllerMock)

        // Then
        XCTAssertNotNil(viewModel.view)
    }
    
//    func getCurrentWeather(cityName: String?) {
//        self.useCases?.executeGetCurrentWeather(cityName: cityName)
//
//        //Step 2: check if the weather is found
//        useCases?.completionHandler { (weather, status, message) in
//
//            if let weather = weather, status {
//                self.view?.displayWeather(weather: weather)
//            } else {
//                print("weather not found")
//            }
//        }
//    }
    
    func testGetCurrentWeather() {
        // Given
        let cityName = "Paris"
        useCasesMock.executeGetCurrentWeatherCityName = cityName
        useCasesMock.executeGetCurrentWeatherModelMock = WeatherModel(conditionID: 200, cityName: "Paris", temperature: 1.0)
        viewControllerMock.displayWeatherExpectation = expectation(description: "Expect Display Weather to be called")
        
        // When
        viewModel.getCurrentWeather(cityName: cityName)
        
        // Then
        waitForExpectations(timeout: 5) { (_) in
            XCTAssertEqual(self.useCasesMock.executeGetCurrentWeatherModelMock?.cityName, self.viewControllerMock.displayWeatherModel?.cityName)
        }
        
    }
    
    func testGetCurrentWeatherWithoutWeatherModel() {
        // Given
        let cityName = "Paris"
        useCasesMock.executeGetCurrentWeatherCityName = cityName
        useCasesMock.executeGetCurrentWeatherModelMock = WeatherModel(conditionID: 200, cityName: "Paris", temperature: 1.0)
        viewControllerMock.displayWeatherExpectation = expectation(description: "Expect Display Weather to be called")
        
        // When
        viewModel.getCurrentWeather(cityName: cityName)
        
        // Then
        waitForExpectations(timeout: 5) { (_) in
            XCTAssertEqual(self.useCasesMock.executeGetCurrentWeatherModelMock?.cityName, self.viewControllerMock.displayWeatherModel?.cityName)
        }
        
    }
    
    // func testMethod() {
    //     // Given
    //     useCasesMock.methodResult = someMock
    //     useCasesMock.asyncMethodResult = .success(someMock)
    //
    //     // When
    //     viewModel.method()
    //
    //     // Then
    //     XCTAssertTrue(viewControllerMock.methodCalled)
    // }
    //
    // func testAsyncMethod() {
    //     // Given
    //     let expectation = self.expectation("expect asyncMethod to be success")
    //     useCasesMock.methodResult = someMock
    //
    //     // When
    //     viewModel.asyncMethod() { result in
    //         switch result {
    //         case .success:
    //             XCTAssertTrue(true)
    //         case .failure:
    //             XCTFail("reason")
    //         }
    //         expectation.fulfill()
    //     }
    //
    //     // Then
    //     waitForExpectations(timeout: 1) {
    //         XCTAssertTrue(true)
    //     }
    // }

}
