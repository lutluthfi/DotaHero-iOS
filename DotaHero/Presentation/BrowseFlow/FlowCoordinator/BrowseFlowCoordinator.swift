//
//  BrowseFlowCoordinator.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/04/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation
import UIKit

// MARK: BrowseFlowCoordinatorFactory
public protocol BrowseFlowCoordinatorFactory  {
    func makeBSListController(requestValue: BSListViewModelRequestValue,
                              route: BSListViewModelRoute) -> UIViewController
}

// MARK: BrowseFlowCoordinator
public protocol BrowseFlowCoordinator {
    func start(with instructor: BrowseFlowCoordinatorInstructor)
}

// MARK: BrowseFlowCoordinatorInstructor
public enum BrowseFlowCoordinatorInstructor {
    case pushToListUI(BSListViewModelRequestValue)
}

// MARK: DefaultBrowseFlowCoordinator
public final class DefaultBrowseFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let controllerFactory: BrowseFlowCoordinatorFactory
    let flowFactory: FlowCoordinatorFactory

    // MARK: Init Funciton
    public init(navigationController: UINavigationController, factory: PresentationFactory) {
        self.navigationController = navigationController
        self.controllerFactory = factory
        self.flowFactory = factory
    }
    
}

extension DefaultBrowseFlowCoordinator: BrowseFlowCoordinator {
    
    public func start(with instructor: BrowseFlowCoordinatorInstructor) {
        switch instructor {
        case .pushToListUI(let requestValue):
            self.pushToListUI(requestValue: requestValue)
        }
    }
    
}

extension DefaultBrowseFlowCoordinator {
    
    private func makeListUI(requestValue: BSListViewModelRequestValue) -> UIViewController {
        let route = BSListViewModelRoute()
        let controller = self.controllerFactory.makeBSListController(requestValue: requestValue, route: route)
        return controller
    }
    
    func pushToListUI(requestValue: BSListViewModelRequestValue) {
        guaranteeMainThread { [unowned self] in
            let scene = self.makeListUI(requestValue: requestValue)
            self.navigationController.pushViewController(scene, animated: true)
        }
    }
    
}
