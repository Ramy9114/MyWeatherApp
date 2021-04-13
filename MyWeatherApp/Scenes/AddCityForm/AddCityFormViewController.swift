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
    func dismissVC(alert: String)
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
        let cityName = cityNameTextField.text
        addCity(cityName: cityName!)
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
    
    func dismissVC(alert: String) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.didAddCity(alert: alert)
    }
}

// MARK: - View Functions called from ViewModel
extension AddCityFormViewController {
    func alertUser(alert: String) {
        Alert.showBasic(title: "", message: alert, vc: self)
    }
}

// MARK: - Implementation for Loading popup (PLEASE IGNORE THIS SECTION)
//        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.gray
//        loadingIndicator.startAnimating();
//
//        alert.view.addSubview(loadingIndicator)
//        present(alert, animated: true, completion: nil)
