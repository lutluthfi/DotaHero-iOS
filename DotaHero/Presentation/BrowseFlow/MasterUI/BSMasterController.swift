//
//  BSMasterController.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/04/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: BSMasterController
final class BSMasterController: UISplitViewController {

    // MARK: DI Variable
    lazy var _view: BSMasterView = DefaultBSMasterView()
    var viewModel: BSMasterViewModel!

    // MARK: Common Variable


    // MARK: Create Function
    class func create(with viewModel: BSMasterViewModel) -> BSMasterController {
        let controller = BSMasterController()
        controller.viewModel = viewModel
        return controller
    }

    // MARK: UIViewController Function
    // override func loadView() {
    //     self.view = (self._view as! UIView)
    // }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(to: self.viewModel)
        self.viewModel.viewDidLoad()
        let viewControllerSatu = UIViewController()
        viewControllerSatu.view.backgroundColor = .red
        let viewControllerDua = UIViewController()
        viewControllerDua.view.backgroundColor = .blue
        self.viewControllers = [UINavigationController(rootViewController: viewControllerDua), viewControllerSatu]
        self.preferredPrimaryColumnWidthFraction = 1/3
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
    private func bind(to viewModel: BSMasterViewModel) {
    }
    
}

// MARK: Observe ViewModel Function
extension BSMasterController {
    
}

// MARK: BSMasterViewDelegate
extension BSMasterController: BSMasterViewDelegate {

}
