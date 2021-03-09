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

class CitiesTableViewController: UIViewController {

    //UI
    @IBOutlet weak var tableView: UITableView!
    
//    var cities: [City] = []
    private var models = [CityItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    

    override func viewDidLoad() {
        super.viewDidLoad()
        getCities()
        
    }
    
    //Adding a City to the Table View
    @IBAction func addCity(_ sender: Any) {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addTextField { (cityTF) in cityTF.placeholder = "Enter City" }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let city = alert.textFields?.first?.text else {return}
            self.createCity(name: city)
            self.tableView.reloadData()
            
            //It is from here that i call the ViewModel Function
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

//MARK: - Managing TableView Delegate and DataSource Content
extension CitiesTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        cell.cityNameLabel?.text = model.name
        cell.forwardImage.image = UIImage(named:"ios-forward-icon")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let Curritem : CityItem = models[indexPath.row]
        deleteCity(item: Curritem)
        models.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

//MARK: - TableView Populator
extension CitiesTableViewController {
    
    func getCities() {
        do{
            models = try context.fetch(CityItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            // error
            
        }
    }
    
    func createCity(name: String) {
        let newItem = CityItem(context: context)
        newItem.name = name
        do {
            try context.save()
            getCities()
        } catch {
            //error
        }
    }
    
    func deleteCity (item: CityItem) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            //error
        }
    }
    
}
