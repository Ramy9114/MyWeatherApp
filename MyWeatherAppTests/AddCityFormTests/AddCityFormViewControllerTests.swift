//
//  AddCityFormViewControllerTests.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 24/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import MyWeatherApp

// MARK: - AddCityFormViewControllerMock
class AddCityFormViewControllerMock: AddCityFormViewProtocol {
    func addCity(cityName: String) {
        
    }
    
    var alertUserExpectation: XCTestExpectation?
    var alertUserString: String?
    func alertUser(alert: String) {
        alertUserString = alert
        alertUserExpectation?.fulfill()
    }
    
    func dismissVC() {
        
    }
    
}

// MARK: - AddCityFormViewControllerTests
class AddCityFormViewControllerTests: XCTestCase {
    var viewModelMock: AddCityFormViewModelMock!
    var viewController: AddCityFormViewController!

    override func setUp() {
        super.setUp()
        viewModelMock = AddCityFormViewModelMock()
        viewController = AddCityFormViewController()
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
//        let _ = AddCityFormViewController(viewModel: viewModelMock)

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
