//
//  WeatherServiceTest.swift
//  MyWeatherAppTests
//
//  Created by Rami Moubayed on 30/03/2021.
//

import XCTest
@testable import MyWeatherApp

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

}
