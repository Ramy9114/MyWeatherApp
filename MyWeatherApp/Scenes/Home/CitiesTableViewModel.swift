//
//  CitiesTableViewModel.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 08/03/2021.
//

import Foundation
import CoreData

protocol CitiesTableViewModelProtocol: class {
    func bindToView(view: CitiesTableViewProtocol)
    func getCities()
    func deleteCity (cityName: String, index: Int)
    func getNumberOfCities() -> Int
    var datasource: [String] {get}
}

final class CitiesTableViewModel {
    // MARK: - Public variables
    private var models = [CityItem]()
    var datasource = [String]()
    weak var view: CitiesTableViewProtocol?
    // MARK: - Private variables
//    private let navigations: GenericViewModelNavigation?
    private let useCases: CitiesTableUseCasesProtocol?
    // MARK: - Initialization
    init (useCases: CitiesTableUseCasesProtocol) {
        self.useCases = useCases
    }
}

extension CitiesTableViewModel: CitiesTableViewModelProtocol {
    func bindToView(view: CitiesTableViewProtocol) {
        self.view = view
    }
    
    func getNumberOfCities() -> Int {
        return datasource.count
    }
    
    func getCities() {
        if let cities = useCases?.executeGetCities() {
            datasource.removeAll()
            for city in cities {
//                print(city.name)
                if let name = city.name {
                    datasource.append(name)
                }
            }
            print(datasource)
        }
    }

    func deleteCity (cityName: String, index: Int) {
        useCases?.executeDeleteCity(cityName: cityName)
        datasource.remove(at: index)
        DispatchQueue.main.async {
            self.view?.reloadCities()
        }
    }
}
