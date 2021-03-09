//
//  GenericViewController.swift
//  MyWeatherApp
//
//  Created by Rami Moubayed on 08/03/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol GenericViewProtocol: class {

}

class GenericViewController: UIViewController {

    // MARK: - IBOutlets

    // MARK: - Public properties

    private var viewModel: GenericViewModelProtocol!

    // MARK: - Private properties

    // MARK: - View lifecycle

    init(viewModel: GenericViewModelProtocol) {
        super.init(nibName: String(describing: GenericViewController.self), bundle: nil)
        self.viewModel = viewModel
        self.viewModel.bindToView(view: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Display logic
    
    func setupUI() {

        setupLocalization()
    }

    func setupLocalization() {

    }

    // MARK: - Actions

    // MARK: - Overrides

    // MARK: - Private functions

}

extension GenericViewController:  GenericViewProtocol {

}
