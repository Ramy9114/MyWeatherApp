//
//  CitiesListViewController.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 08/03/2021.
//

import UIKit
import CoreData
import Alamofire
import Swinject

protocol CitiesTableViewProtocol: class {
    func getCities()
    func createCity(cityName: String)
    func deleteCity(cityName: String, index: Int)
    func alertUser (alert: String)
    func reloadCities()
}

class CitiesTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Public properties
    private var viewModel: CitiesTableViewModelProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CitiesTableViewModel(useCases: CitiesTableUseCases(citiesRepository: CitiesRepository(coreDataManager: CoreDataManager(), weatherService: WeatherService())))
        self.viewModel.bindToView(view: self)
        self.getCities()
    }

    @IBAction func addCity(_ sender: Any) {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addTextField { (cityTF) in cityTF.placeholder = "Enter City" }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let city = alert.textFields?.first?.text?.capitalized else {return}
            self.createCity(cityName: city)
            self.getCities()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - Managing TableView Delegate and DataSource Content
extension CitiesTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfCities()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = viewModel.datasource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        cell.cityNameLabel?.text = name
        cell.forwardImage.image = UIImage(named: "ios-forward-icon")
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let curritem = viewModel.datasource[indexPath.row]
        self.deleteCity(cityName: curritem, index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

// MARK: - TableView Go To Weather Detail Segue
extension CitiesTableViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToWeatherDetail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WeatherDetailViewController {
            destination.cityName = self.viewModel.datasource[(tableView.indexPathForSelectedRow?.row)!]
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
}

// MARK: - TableView Populator
extension CitiesTableViewController: CitiesTableViewProtocol {

    func createCity(cityName: String) {
        viewModel.createCity(cityName: cityName)
    }

    func getCities() {
        viewModel.getCities()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func deleteCity(cityName: String, index: Int) {
        viewModel.deleteCity(cityName: cityName, index: index)
    }

    func reloadCities() {
        self.tableView.reloadData()
    }

}

// MARK: - View Functions called from ViewModel
extension CitiesTableViewController {
    func alertUser(alert: String) {
        Alert.showBasic(title: "", message: alert, vc: self)
        self.getCities()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
