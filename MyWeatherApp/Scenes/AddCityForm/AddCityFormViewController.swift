//
//  AddCityFormViewController.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 22/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AddCityFormViewModelDelegate: class {
    func didAddCity(alert: String)
}

protocol AddCityFormViewProtocol: class {
    func addCity(cityName: String)
    func alertUser (alert: String)
    func dismissVC()
}

class AddCityFormViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Public properties
    weak var delegate: AddCityFormViewModelDelegate?
    // MARK: - Private properties
    var viewModel: AddCityFormViewModelProtocol!
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        disableSubmitButton()
        cityNameTextField.delegate = self
        self.viewModel = AddCityFormViewModel(useCases: CitiesTableUseCases(citiesRepository: CitiesRepository(coreDataManager: CoreDataManager(), weatherService: WeatherService())))
        self.viewModel.bindToView(view: self)
        
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        // Clear the content of the Textfield
        // Make the rest of the process
        let cityName = cityNameTextField.text
        addCity(cityName: cityName!)
        
//        Alert.showBasic(title: "", message: "Hello", vc: self)
    }
    
    // MARK: - Display logic
    func disableSubmitButton() {
        submitButton.backgroundColor = .gray
        submitButton.isEnabled = false
    }
    
    func enableSubmitButton() {
        submitButton.backgroundColor = .orange
        submitButton.isEnabled = true
    }
    
    // MARK: - Actions

    // MARK: - Overrides

    // MARK: - Private functions
}

extension AddCityFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            enableSubmitButton()
        } else {
            disableSubmitButton()
        }
    }
    
}

extension AddCityFormViewController: AddCityFormViewProtocol {

    func addCity(cityName: String) {
        viewModel.addCity(cityName: cityName)
        
    }
    
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.didAddCity(alert: "City Successfully Added!")
    }
}

// MARK: - View Functions called from ViewModel
extension AddCityFormViewController {
    func alertUser(alert: String) {
        Alert.showBasic(title: "", message: alert, vc: self)
    }
}
