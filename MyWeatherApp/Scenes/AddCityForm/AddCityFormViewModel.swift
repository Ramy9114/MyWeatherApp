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
//    weak var delegate: AddCityFormViewModelDelegate?

    // MARK: - Private variables
    private let useCases: CitiesTableUseCasesProtocol?

    // MARK: - Initialization
    init (useCases: CitiesTableUseCasesProtocol) {
        self.useCases = useCases
    }

    func bindToView(view: AddCityFormViewProtocol) {
        self.view = view
    }
}

extension AddCityFormViewModel: AddCityFormViewModelProtocol {
    
    func addCity(cityName: String) {
        // Check if the City already exists in Core Data
        // executeIfCityExists
        let response = useCases?.executeCheckIfCityExists(cityName: cityName)
        
        if response  == .cityAlreadyInlist {
            self.view?.alertUser(alert: "City already exists in the list")
        } else {
            // Check if the Weather API will return the city.
            useCases?.executeGetCity(cityName: cityName, completion: { (weather, status, message) in
                if status {
                    let response = self.useCases?.executeSaveCity(cityName: cityName)
                    switch response {
                    case .cannotSave:
                        self.view?.alertUser(alert: "Something Went Wrong, Please try again")
                    case .processComplete:
                        self.view?.dismissVC()
                    case .cityNotFound:
                        self.view?.alertUser(alert: "City Not Found")
                    case .none:
                        self.view?.alertUser(alert: "Nothing Happened")
                    case .cityAlreadyInlist:
                        print()
                    }
                } else {
                    self.view?.alertUser(alert: message)
                }
            })
        }
    }
    
}
