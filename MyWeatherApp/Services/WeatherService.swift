//
//  WeatherService.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 17/03/2021.
//

import Foundation
import Alamofire

enum WeatherResponseError: Error {
    case cannotSave
    case processComplete
}

protocol WeatherServiceProtocol {
    func fetchCurrentWeather(cityName: String?, completion: @escaping  (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void)
}

class WeatherService: WeatherServiceProtocol {
    let APIKEY = "fac449c53f5bc8239820342f79d4edd7"
    
    func fetchCurrentWeather(cityName: String?, completion: @escaping  (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void) {
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=\(cityName!)&appid=\(APIKEY)&units=metric")
            .responseJSON {(response) in
                guard let data = response.data else {return}
                let weather = self.parseJSON(data)
                if weather != nil {
                    completion(weather, true, "City found with weather")
                } else {
                    completion(nil, false, "City not found")
                }
            }
    }
    
}

// MARK: - JSON Decoding
extension WeatherService {
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        do {
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: weatherData)
            let weatherID = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name

            let weather = WeatherModel(conditionID: weatherID, cityName: name, temperature: temp)
            return weather
        } catch {
            return nil
        }
    }
}
