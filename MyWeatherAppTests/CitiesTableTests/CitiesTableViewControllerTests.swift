//
//  CitiesTableViewControllerTests.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 18/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import MyWeatherApp

// MARK: - CitiesTableViewControllerMock
class CitiesTableViewControllerMock: CitiesTableViewProtocol {
    func getCities() {
        
    }
    
    func createCity(name: String) {
        
    }
    
    func deleteCity(cityName: String, index: Int) {
        
    }
    
    func reloadCities() {
        
    }
    
    var alertUserExpectation: XCTestExpectation?
    var alertUserString: String?
    func alertUser(alert: String) {
        alertUserString = alert
        alertUserExpectation?.fulfill()
    }

//    var updateSearchBarTextMock: String?
//    func updateSearchBarText(address: String) {
//        updateSearchBarTextMock = address
//    }

    // var methodResult: String?
    // var methodCalled: Bool = false
    // func method() -> String? {
    //     methodCalled = true
    //     return methodResult = "string"
    // }
}

// MARK: - CitiesTableViewControllerTests
class CitiesTableViewControllerTests: XCTestCase {
    var viewModelMock: CitiesTableViewModelMock!
    var viewController: CitiesTableViewController!

    override func setUp() {
        super.setUp()
        viewModelMock = CitiesTableViewModelMock()
        viewController = CitiesTableViewController()
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
//        let _ = CitiesTableViewController()

        // Then
        XCTAssertTrue(viewModelMock.bindToViewCalled)
    }

    // func testMethod() {
    //     // Given
    //     let someData = someMock
    //
    //     // When
    //     viewController.method(someData)
    //
    //     // Then
    //     XCTAssertEqual(viewController.someOutlet, someData)
    //     XCTAssertTrue(viewModelMock.methodCalled)
    // }
}
