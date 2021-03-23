//
//  AddCityFormUseCases.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 22/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AddCityFormUseCasesProtocol: class {
    func executeCheckCityFromCoreData(cityName: String) -> CoreDataError?
    func executeGetCity(cityName: String, completion: @escaping (_ weather: WeatherModel?, _ status: Bool, _ message: String) -> Void)
    func executeSaveCity(cityName: String) -> CoreDataError?

}

final class AddCityFormUseCases {

    // MARK: - Private variables
    private let addCityFormRepository: AddCityFormRepositoryProtocol?

    // MARK: - Initialization
    init(addCityFormRepository: AddCityFormRepositoryProtocol) {
        self.addCityFormRepository = addCityFormRepository
    }

    // MARK: - Execute functions

}

extension AddCityFormUseCases: AddCityFormUseCasesProtocol {
    
    func executeCheckCityFromCoreData(cityName: String) -> CoreDataError? {
        return addCityFormRepository?.fetchCityFromCoreData(cityName: cityName)
    }
    
    func executeGetCity(cityName: String, completion: @escaping (WeatherModel?, Bool, String) -> Void) {
        addCityFormRepository?.fetchCity(cityName: cityName, completion: { (weather, status, message) in
            if status {
                guard let weather = weather else {return}
                completion(weather, true, message)
            } else {
                completion(nil, false, message)
            }
        })
    }
    
    func executeSaveCity(cityName: String) -> CoreDataError? {
        return addCityFormRepository?.saveCity(cityName: cityName)
    }
}
