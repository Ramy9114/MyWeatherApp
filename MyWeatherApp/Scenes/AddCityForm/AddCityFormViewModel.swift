//
//  AddCityFormViewModel.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 22/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol AddCityFormViewModelProtocol: class {
    func bindToView(view: AddCityFormViewProtocol)
    func addCity(cityName: String)
}

final class AddCityFormViewModel {

    // MARK: - Public variables
    weak var view: AddCityFormViewProtocol?

    // MARK: - Private variables
    private let useCases: AddCityFormUseCasesProtocol?

    // MARK: - Initialization
    init (useCases: AddCityFormUseCasesProtocol) {
        self.useCases = useCases
    }

    func bindToView(view: AddCityFormViewProtocol) {
        self.view = view
    }
}

extension AddCityFormViewModel: AddCityFormViewModelProtocol {
    func addCity(cityName: String) {
        useCases?.executeAddCity(cityName: cityName)
    }
}
