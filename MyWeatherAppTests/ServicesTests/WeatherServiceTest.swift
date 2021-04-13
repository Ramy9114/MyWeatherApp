//
//  WeatherServiceTest.swift
//  MyWeatherAppTests
//
//  Created by Rami Moubayed on 30/03/2021.
//

import XCTest
@testable import MyWeatherApp
import Mocker
import Alamofire

class WeatherServiceTest: XCTestCase {
    
    var weatherService: WeatherService!
    
    override func setUp() {
        super.setUp()
        weatherService = WeatherService()
    }

    override func tearDown() {
        weatherService = nil
        super.tearDown()
    }
    
    func testParseJSONSuccess() throws {
        // Given
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "weather", ofType: "json") else {
            fatalError("JSON file was not found")
        }
        
        guard let weatherData = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert JSON to String")
        }
        
        let jsonData = weatherData.data(using: .utf8)!
        let decodedData = try! JSONDecoder().decode(WeatherData.self, from: jsonData)
        
        // When
        weatherService.parseJSON(jsonData) 
        
        // Then
        XCTAssertEqual(decodedData.weather[0].id, 800)
        XCTAssertEqual(decodedData.main.temp, 23.37)
        XCTAssertEqual(decodedData.name, "Paris")
    }
    
    func testParseJSONWithWrongCityName() throws {
        // Given
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "corruptedWeather", ofType: "json") else {
            fatalError("JSON file was not found")
        }
        
        guard let weatherData = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert JSON to String")
        }
        
        let jsonData = weatherData.data(using: .utf8)!
        let decodedData = try JSONDecoder().decode(WeatherData.self, from: jsonData)
        
        // When
        weatherService.parseJSON(jsonData)
        
        // Then
        XCTAssertNotEqual(decodedData.name, "Paris")
    }
    
    func testFetchCurrentWeatherSuccess() {
        // Given
        let cityName = "Paris"
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(weatherService.APIKEY)&units=metric"

        // Step 1: Add a Custom URL Protocol
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let sessionManager = Session(configuration: configuration)

        // Step 2: Define URL and expected Data
        let apiEndpoint = URL(string: url)!
        let expectedWeather = WeatherData(name: "Paris", main: Main(temp: 50.0), weather: [Weather(id: 200, description: "Rainy")])
        let requestExpectation = expectation(description: "Request should finish")
        
        // Step 3: Register Mock Response by Encoding Model
        let mockedData = try! JSONEncoder().encode(expectedWeather)
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
        mock.register()
        
        // When
        weatherService.fetchCurrentWeather(cityName: cityName) { (weatherModel, status, message) in
        
        // Then
        sessionManager
            .request(apiEndpoint)
            .responseDecodable(of: WeatherData.self) { (response) in
                XCTAssertNil(response.error)
                XCTAssertEqual(response.value?.name, expectedWeather.name)

                requestExpectation.fulfill()
            }.resume()
        }
        self.wait(for: [requestExpectation], timeout: 10.0)
         
    }
    
    func testFetchCurrentWeatherFailure() {
        // Given
        // Step 1
        let cityName = "XXXX"
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(weatherService.APIKEY)&units=metric"
        
        // Step 2: Add a Custom URL Protocol
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let sessionManager = Session(configuration: configuration)

        // Step 3: Define URL and expected Data
        let apiEndpoint = URL(string: url)!
        let expectedStatusCode = 404
        let requestExpectation = expectation(description: "Request should fail")
        
        // Step 4: Register Mock Response by Encoding Model
        let mockedData = try! JSONEncoder().encode(expectedStatusCode)
        let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 404, data: [.get: mockedData])
        mock.register()
        
        // When
//        weatherService.fetchCurrentWeather(cityName: cityName) { (weatherModel, status, message) in
        
        // Then
        sessionManager
            .request(apiEndpoint)
            .responseDecodable(of: WeatherData.self) { (response) in
                XCTAssertNotNil(response.error)
//                XCTAssertNotEqual(response.value?.name, expectedWeather.name)
//                XCTAssertEqual(response.value?.name, weatherModel?.cityName)
                requestExpectation.fulfill()
            }.resume()
//        }
        self.wait(for: [requestExpectation], timeout: 10.0)
    }
}
