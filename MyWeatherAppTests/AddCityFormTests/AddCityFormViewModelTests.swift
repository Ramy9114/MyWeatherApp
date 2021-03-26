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
    
    // MARK: - FIRST IF ELSE
    
    // 1 - check if city exists (success)
    func testAddCityWithCityFound() {
        // Given
        let cityName = "Paris"
        let alertString = "City already exists in the list"
        
        useCasesMock.executeCheckIfCityExistsErrorResponse = .cityAlreadyInlist
        
        // When
        viewModel.addCity(cityName: cityName)
        
        // Then
        XCTAssertEqual(self.viewControllerMock.alertUserString, alertString)
    }
    
    // 2 - check if city exists (failure)
    func testAddCityWithCityNotFound() {
        // Given
        let cityName = "Paris"
        useCasesMock.executeCheckIfCityExistsErrorResponse = .none
        
        // When
        viewModel.addCity(cityName: cityName)
        
        // Then
        XCTAssertTrue(useCasesMock.executeGetCityCalled)
    }
    
    // MARK: - SECOND IF ELSE
    
    // 2 - get city from Weather API (success)
    func testAddCityWithGetCitySuccess() {
        // Given
        let cityName = "Paris"
        useCasesMock.executeCheckIfCityExistsErrorResponse = .none
        useCasesMock.executeGetCityWeatherModelMock = WeatherModel(conditionID: 200, cityName: "Paris", temperature: 1.0)
        useCasesMock.executeGetCityStatusMock = true
        useCasesMock.executeGetCityMessageMock = "City Successfully Added"
        
        // When
        viewModel.addCity(cityName: cityName)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.useCasesMock.executeSaveCityCalled)
        }
    }
    
    func testAddCityWithGetCityFailure() {
        // Given
        let cityName = "Paris"
        let message = "City Not Found"
//        let alertString = "City already exists in the list"
        useCasesMock.executeCheckIfCityExistsErrorResponse = .none
        useCasesMock.executeGetCityWeatherModelMock = nil
        useCasesMock.executeGetCityStatusMock = false
        useCasesMock.executeGetCityMessageMock = message
        viewControllerMock.alertUserExpectation = expectation(description: "Expect Alert User to be called")
        
        // When
        viewModel.addCity(cityName: cityName)
        
        // Then
        waitForExpectations(timeout: 3) { (_) in
            XCTAssertEqual(self.useCasesMock.executeGetCityMessageMock, self.viewControllerMock.alertUserString)
        }
        
    }
    
    // MARK: - SWITCH CASES
    
    func testAddCityWithSaveCityProcessComplete() {
        // Given
        let cityName = "Paris"
        let alertString = "City Successfully Added!"
        let message = "City Not Found"
        useCasesMock.executeCheckIfCityExistsErrorResponse = .none
        useCasesMock.executeGetCityWeatherModelMock = WeatherModel(conditionID: 200, cityName: "Paris", temperature: 1.0)
        useCasesMock.executeGetCityStatusMock = true
        useCasesMock.executeGetCityMessageMock = "City Successfully Added"
        useCasesMock.executeSaveCityErrorResponse = .processComplete
        viewControllerMock.dismissVCExpectation = expectation(description: "Expect DismissVC to be called")
        
        // When
        viewModel.addCity(cityName: cityName)
        
        
        // Then
        waitForExpectations(timeout: 2) { (_) in
            XCTAssertEqual(self.viewControllerMock.dismissVCAlertString, alertString)
        }
        
    }
    
}
