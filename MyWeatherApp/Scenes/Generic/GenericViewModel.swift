//
//  GenericViewModel.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 08/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol GenericViewModelProtocol: class {
    func bindToView(view: GenericViewProtocol)
}

final class GenericViewModel {

    // MARK: - Public variables

    weak var view: GenericViewProtocol?

    // MARK: - Private variables

    private let navigations: GenericViewModelNavigation?
    private let useCases: GenericUseCasesProtocol?

    // MARK: - Initialization

    init (useCases: GenericUseCasesProtocol, navigations: GenericViewModelNavigation) {
        self.navigations = navigations
        self.useCases = useCases
    }

    func bindToView(view: GenericViewProtocol) {
        self.view = view
    }
}

extension GenericViewModel: GenericViewModelProtocol {

}
