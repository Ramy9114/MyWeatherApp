//
//  AddCityFormUseCases.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 22/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AddCityFormUseCasesProtocol: class {
    func executeAddCity(cityName: String)
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
    func executeAddCity(cityName: String) {
        
    }
    
}
