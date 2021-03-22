//
//  AddCityFormViewController.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 22/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AddCityFormViewProtocol: class {

}

class AddCityFormViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Public properties

//    private var viewModel: AddCityFormViewModelProtocol!

    // MARK: - Private properties

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        cityNameTextField.delegate = self
        disableSubmitButton()
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        cityNameTextField.endEditing(true)
        
        if cityNameTextField.text == "" {
            
        }
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

}
