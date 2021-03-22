////
////  AddCityFormViewModel.swift
////  MyWeatherApp
////
////  Created by Rami Moubayed on 22/03/2021.
////  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
////
//
//import UIKit
//
//protocol AddCityFormViewModelProtocol: class {
//    func bindToView(view: AddCityFormViewProtocol)
//}
//
//final class AddCityFormViewModel {
//
//    // MARK: - Public variables
//
//    weak var view: AddCityFormViewProtocol?
//
//    // MARK: - Private variables
//
//    private let navigations: AddCityFormViewModelNavigation?
//    private let useCases: AddCityFormUseCasesProtocol?
//
//    // MARK: - Initialization
//
//    init (useCases: AddCityFormUseCasesProtocol, navigations: AddCityFormViewModelNavigation) {
//        self.navigations = navigations
//        self.useCases = useCases
//    }
//
//    func bindToView(view: AddCityFormViewProtocol) {
//        self.view = view
//    }
//}
//
//extension AddCityFormViewModel: AddCityFormViewModelProtocol {
//
//}
