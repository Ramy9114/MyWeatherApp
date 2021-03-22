//
//  WeatherDetailViewController.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 16/03/2021.
//

import UIKit

protocol WeatherDetailViewProtocol: class {
    func getCurrentWeather(cityName: String?)
    func displayWeather(weather: WeatherModel)
}

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    var cityName: String?
    // MARK: - Public properties
    private var viewModel: WeatherDetailViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = WeatherDetailViewModel(useCases: WeatherDetailUseCases(weatherDetailRepository: WeatherDetailRepository(weatherService: WeatherService())))
        self.viewModel.bindToView(view: self)
        cityNameLabel.text = cityName
        getCurrentWeather(cityName: cityName)
    }
}

extension WeatherDetailViewController: WeatherDetailViewProtocol {
    func displayWeather(weather: WeatherModel) {
        print("here i am printing the weather")
        temperatureLabel.text = String(Int(weather.temperature))
        weatherImageView.image = UIImage(named: weather.conditionName)
    }
    func getCurrentWeather(cityName: String?) {
        viewModel?.getCurrentWeather(cityName: cityName)
    }
}
