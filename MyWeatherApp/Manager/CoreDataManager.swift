//
//  CoreDataManager.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 10/03/2021.
//

import Foundation
import CoreData
import UIKit
import Alamofire

enum CoreDataError: Error {
    case cannotSave
    case processComplete
    case cityNotFound
    case cityAlreadyInlist
}

typealias WeatherCallBack = (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void

protocol CoreDataManagerProtocol {
    func saveCity(cityName: String) -> CoreDataError?
    func getCity (cityName: String, completion: @escaping(_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void)
    func checkCityFromCoreData(cityName: String) -> CoreDataError?
    func getCities() -> [CityItem]
    func deleteCity (cityName: String)
}

class CoreDataManager: CoreDataManagerProtocol {
    
    var callBack: WeatherCallBack?
    let API_KEY = "fac449c53f5bc8239820342f79d4edd7"
    var BASEURL = "https://api.openweathermap.org/data/2.5/weather?q=London&appid=fac449c53f5bc8239820342f79d4edd7"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models = [CityItem]()
    
    func getCities() -> [CityItem] {
        do {
            models = try context.fetch(CityItem.fetchRequest())
            return models
        } catch {
            return []
        }
    }

    func saveCity(cityName: String) -> CoreDataError? {
        let cityItem = CityItem(context: self.context)
        cityItem.name = cityName
        
        do {
            try context.save()
            return .processComplete

        } catch {
            return .cannotSave
        }
    }
    
    func deleteCity(cityName: String) {
       let cities = getCities()
        for city in cities {
            if city.name == cityName {
                context.delete(city)
                do {
                    try context.save()
                } catch {
                    // error
                    print("Could not delete")
                }
            }
        }
        print(getCities())
    }
    func getCity(cityName: String, completion: @escaping  (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void) {
        var existsInCoreData = false
        // 1 check if the city already exists in Core Data
        let models = self.getCities()
        if !models.isEmpty {
            for model in models {
                if model.name == cityName {
                    completion(nil, false, "City is already on the list!")
                    existsInCoreData = true
                }
            }
        }
        if !existsInCoreData {
            AF.request("https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(API_KEY)")
                .responseJSON {(response) in
                    guard let data = response.data else {return}
                    let weather = self.parseJSON(data)
                    print(weather)
                    if weather != nil {
                        print("i found it")
                        completion(weather, true, "City found with weather")
                    } else {
                        print("i didn't find it")
                        completion(nil, false, "The City Does Not Exist!")
                        
                    }
                }
        }
    }
    
    func checkCityFromCoreData(cityName: String) -> CoreDataError? {
        // Check if city already exists in Core Data
        let models = self.getCities()
        if !models.isEmpty {
            for model in models {
                if model.name == cityName {
                    return .cityAlreadyInlist
                }
            }
        }
        return .none
    }

}

// MARK: - JSON Decoding
extension CoreDataManager {
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
