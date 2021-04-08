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
    
    func makeBSDetailController(requestValue: BSDetailViewModelRequestValue,
                                route: BSDetailViewModelRoute) -> UIViewController
}

// MARK: BrowseFlowCoordinator
public protocol BrowseFlowCoordinator {
    func start(with instructor: BrowseFlowCoordinatorInstructor)
}

// MARK: BrowseFlowCoordinatorInstructor
public enum BrowseFlowCoordinatorInstructor {
    case pushToDetailUI(BSDetailViewModelRequestValue)
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
        case .pushToDetailUI(let requestValue):
            self.pushToDetailUI(requestValue: requestValue)
        case .pushToListUI(let requestValue):
            self.pushToListUI(requestValue: requestValue)
        }
    }
    
}

// MARK: BSDetailUI
extension DefaultBrowseFlowCoordinator {
    
    private func makeDetailUI(requestValue: BSDetailViewModelRequestValue) -> UIViewController {
        let route = BSDetailViewModelRoute()
        let controller = self.controllerFactory.makeBSDetailController(requestValue: requestValue, route: route)
        return controller
    }
    
    func pushToDetailUI(requestValue: BSDetailViewModelRequestValue) {
        guaranteeMainThread { [unowned self] in
            let scene = self.makeDetailUI(requestValue: requestValue)
            self.navigationController.pushViewController(scene, animated: true)
        }
    }
    
}

// MARK: BSListUI
extension DefaultBrowseFlowCoordinator {
    
    private func makeListUI(requestValue: BSListViewModelRequestValue) -> UIViewController {
        let route = BSListViewModelRoute(showBSDetailUI: { requestValue in
            let instructor = BrowseFlowCoordinatorInstructor.pushToDetailUI(requestValue)
            self.start(with: instructor)
        })
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
