//
//  CitiesTableViewModelTests.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 18/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
import UIKit
@testable import MyWeatherApp

class CitiesTableViewModelMock: CitiesTableViewModelProtocol {
    func bindToView(view: CitiesTableViewProtocol) {
        
    }
    
    func getCities() {
        
    }
    
    func createCity(name: String) {
        
    }
    
    func deleteCity(name: String, index: Int) {
        
    }
    
    func getNumberOfCities() -> Int {
        return 1
    }
    
    var datasource: [String] = []
    
    var bindToViewCalled: Bool = false
    func bindToView(view: CitiesTableViewModelProtocol) {
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

class CitiesTableViewModelTests: XCTestCase {
    var viewControllerMock: CitiesTableViewControllerMock!
    var useCasesMock: CitiesTableUseCasesMock!
    var viewModel: CitiesTableViewModel!

    override func setUp() {
        super.setUp()
        viewControllerMock = CitiesTableViewControllerMock()
        useCasesMock = CitiesTableUseCasesMock()
        viewModel = CitiesTableViewModel(useCases: useCasesMock)
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
        let viewModel = CitiesTableViewModel(useCases: useCasesMock)
        let viewControllerMock = CitiesTableViewControllerMock()

        // When
        viewModel.bindToView(view: viewControllerMock)

        // Then
        XCTAssertNotNil(viewModel.view)
    }
    
    // fix expected result and fix sent result
    func testCreateCity() {
        // Given
        let name = "Paris"
        useCasesMock.executeGetCity = name
        useCasesMock.executeGetWeatherModelMock = WeatherModel(conditionID: 200, cityName: "Paris", temperature: 1.0)
        viewControllerMock.alertUserExpectation = expectation(description: "City Successfully Added!")
        
        // When
        viewModel.createCity(name: name)
        
        // Then
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertEqual(self.useCasesMock.executeGetWeatherModelMock?.cityName, name)
        }
        
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func testCreateCityWithCityFound() {
        // Given
        let name = "Paris"
        let cityItem = CityItem(context: context)
        cityItem.name = name
        var alertString: String?
        
        useCasesMock.executeSaveCity = cityItem
        useCasesMock.executeSaveCityCoreDataError = .processComplete
        
        if useCasesMock.executeSaveCityCoreDataError == .processComplete {
            alertString = "City Successfully Added!"
        }
        viewControllerMock.alertUserExpectation = expectation(description: "City Successfully Added!")
        
        // When
        viewModel.createCity(name: name)
        waitForExpectations(timeout: 5) { (_) in
            XCTAssertEqual(alertString, self.viewControllerMock.alertUserString)
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
