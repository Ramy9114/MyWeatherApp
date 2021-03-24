//
//  WeatherDetailViewModel.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 17/03/2021.
//

import Foundation
import UIKit

protocol WeatherDetailViewModelProtocol: class {
    func bindToView(view: WeatherDetailViewProtocol)
    func getCurrentWeather(cityName: String?)
}

final class WeatherDetailViewModel {

    // MARK: - Public variables
    weak var view: WeatherDetailViewProtocol?

    // MARK: - Private variables
    private let useCases: WeatherDetailUseCasesProtocol?

    // MARK: - Initialization

    init (useCases: WeatherDetailUseCasesProtocol) {
        self.useCases = useCases
    }

}

extension WeatherDetailViewModel: WeatherDetailViewModelProtocol {
    func bindToView(view: WeatherDetailViewProtocol) {
        self.view = view
    }
    func getCurrentWeather(cityName: String?) {
        self.useCases?.executeGetCurrentWeather(cityName: cityName, completion: { (weather, status, message) in
            if let weather = weather, status {
                self.view?.displayWeather(weather: weather)
            } else {
                self.view?.weatherNotFound(alert: "Weather was not retrieved, please try again!")
            }
        })
    }
}
