//
//  WeatherDetailViewControllerTests.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 18/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import MyWeatherApp

// MARK: - WeatherDetailViewControllerMock
class WeatherDetailViewControllerMock: WeatherDetailViewProtocol {
    func getCurrentWeather(cityName: String?) {
        
    }
    
    var displayWeatherExpectation: XCTestExpectation?
    var displayWeatherModel: WeatherModel?
    func displayWeather(weather: WeatherModel) {
        displayWeatherModel = weather
        displayWeatherExpectation?.fulfill()
    }
    
//
//    var updateSearchBarTextMock: String?
//    func updateSearchBarText(address: String) {
//        updateSearchBarTextMock = address
//    }

}

// MARK: - WeatherDetailViewControllerTests
class WeatherDetailViewControllerTests: XCTestCase {
    var viewModelMock: WeatherDetailViewModelMock!
    var viewController: WeatherDetailViewController!

    override func setUp() {
        super.setUp()
        viewModelMock = WeatherDetailViewModelMock()
        viewController = WeatherDetailViewController()
        viewController.loadView()
        viewController.viewDidLoad()
    }

    override func tearDown() {
        viewModelMock = nil
        viewController = nil
        super.tearDown()
    }

    func testViewModelBindToView() {
        // Given

        // When
//        let _ = WeatherDetailViewController()

        // Then
        XCTAssertTrue(viewModelMock.bindToViewCalled)
    }
}
