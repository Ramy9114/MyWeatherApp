//
//  AddCityFormViewModelTests.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 24/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import MyWeatherApp

class AddCityFormViewModelMock: AddCityFormViewModelProtocol {
    func bindToView(view: AddCityFormViewProtocol) {
        
    }
    
    func addCity(cityName: String) {
        
    }
    
    var bindToViewCalled: Bool = false
    func bindToView(view: AddCityFormViewModelProtocol) {
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

class AddCityFormViewModelTests: XCTestCase {
    var viewControllerMock: AddCityFormViewControllerMock!
    var useCasesMock: AddCityFormUseCasesMock!
    var viewModel: AddCityFormViewModel!

    override func setUp() {
        super.setUp()
        viewControllerMock = AddCityFormViewControllerMock()
        useCasesMock = AddCityFormUseCasesMock()
        viewModel = AddCityFormViewModel(useCases: useCasesMock)
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
        let viewModel = AddCityFormViewModel(useCases: useCasesMock)
        let viewControllerMock = AddCityFormViewControllerMock()

        // When
        viewModel.bindToView(view: viewControllerMock)

        // Then
        XCTAssertNotNil(viewModel.view)
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
    
    // TESTING ADD CITY FUNCTIONALITY WITH EACH SCENARIO
    
    // 1 - check if city exists (success)
    func testAddCityWithCityCheckSuccess() {
        // Given
        let cityName = "Paris"
        useCasesMock.executeCheckIfCityExistsErrorResponse = .cityAlreadyInlist
        
        // When
        viewModel.addCity(cityName: cityName)
        
        // Then
        XCTAssertEqual(useCasesMock.executeCheckIfCityExistsErrorResponse, .cityAlreadyInlist)
    }
    
    // 2 - check if city exists (failure)
    func testAddCityWithCityCheckFailure() {
        // Given
        let cityName = "Paris"
        useCasesMock.executeCheckIfCityExistsErrorResponse = .none
        
        // When
        viewModel.addCity(cityName: cityName)
        
        // Then
        XCTAssertEqual(useCasesMock.executeCheckIfCityExistsErrorResponse, .none)
    }
    
}
