//
//  BSDetailController.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: BSDetailController
final class BSDetailController: UIViewController {

    // MARK: DI Variable
    lazy var _view: BSDetailView = DefaultBSDetailView()
    var viewModel: BSDetailViewModel!

    // MARK: Common Variable


    // MARK: Create Function
    class func create(with viewModel: BSDetailViewModel) -> BSDetailController {
        let controller = BSDetailController()
        controller.viewModel = viewModel
        return controller
    }

    // MARK: UIViewController Function
    override func loadView() {
        self.view = (self._view as! UIView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(to: self.viewModel)
        self.viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self._view.viewWillAppear(navigationBar: self.navigationController?.navigationBar,
                                  navigationItem: self.navigationItem,
                                  tabBarController: self.tabBarController)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self._view.viewWillDisappear()
    }

    // MARK: Bind ViewModel Function
    private func bind(to viewModel: BSDetailViewModel) {
    }
    
}

// MARK: Observe ViewModel Function
extension BSDetailController {
    
}

// MARK: BSDetailViewDelegate
extension BSDetailController: BSDetailViewDelegate {

}
