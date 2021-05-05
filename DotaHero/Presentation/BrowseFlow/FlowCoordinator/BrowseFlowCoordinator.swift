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
    func makeBSDetailController(request: BSDetailViewModelRequest,
                                route: BSDetailViewModelRoute) -> UIViewController
    
    func makeBSListController(request: BSListViewModelRequest,
                              route: BSListViewModelRoute) -> UIViewController
    
    func makeBSSortController(request: BSSortViewModelRequest,
                              response: BSSortViewModelResponse,
                              route: BSSortViewModelRoute) -> UIViewController
}

// MARK: BrowseFlowCoordinator
public protocol BrowseFlowCoordinator {
    func start(with instructor: BrowseFlowCoordinatorInstructor)
}

// MARK: BrowseFlowCoordinatorInstructor
public enum BrowseFlowCoordinatorInstructor {
    case presentSortUI(BSSortViewModelRequest, BSSortViewModelResponse, UIPresentProperties)
    case pushToDetailUI(BSDetailViewModelRequest)
    case pushToListUI(BSListViewModelRequest)
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
        case .presentSortUI(let request, let response, let presentProperties):
            self.presentSortUI(request: request, response: response, presentProperties: presentProperties)
        case .pushToDetailUI(let request):
            self.pushToDetailUI(request: request)
        case .pushToListUI(let request):
            self.pushToListUI(request: request)
        }
    }
    
}

// MARK: DetailUI
extension DefaultBrowseFlowCoordinator {
    
    private func makeDetailUI(request: BSDetailViewModelRequest) -> UIViewController {
        let route = BSDetailViewModelRoute()
        let controller = self.controllerFactory.makeBSDetailController(request: request, route: route)
        return controller
    }
    
    func pushToDetailUI(request: BSDetailViewModelRequest) {
        guaranteeMainThread { [unowned self] in
            let controller = self.makeDetailUI(request: request)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
}

// MARK: ListUI
extension DefaultBrowseFlowCoordinator {
    
    private func makeListUI(request: BSListViewModelRequest) -> UIViewController {
        let route = BSListViewModelRoute(presentBSSortUI: { (request, response) in
            let presentProperties = UIPresentProperties(isModalInPresentation: true)
            let instructor = BrowseFlowCoordinatorInstructor.presentSortUI(request, response, presentProperties)
            self.start(with: instructor)
        }, pushToBSDetailUI: { (request) in
            let instructor = BrowseFlowCoordinatorInstructor.pushToDetailUI(request)
            self.start(with: instructor)
        })
        let controller = self.controllerFactory.makeBSListController(request: request, route: route)
        return controller
    }
    
    func pushToListUI(request: BSListViewModelRequest) {
        guaranteeMainThread { [unowned self] in
            let controller = self.makeListUI(request: request)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
}

// MARK: SortUI
extension DefaultBrowseFlowCoordinator {
    
    private func makeSortUI(request: BSSortViewModelRequest, response: BSSortViewModelResponse) -> UIViewController {
        let route = BSSortViewModelRoute()
        let constroller = self.controllerFactory.makeBSSortController(request: request,
                                                                      response: response,
                                                                      route: route)
        return constroller
    }
    
    func presentSortUI(request: BSSortViewModelRequest,
                       response: BSSortViewModelResponse,
                       presentProperties: UIPresentProperties) {
        guaranteeMainThread {
            let controller = self.makeSortUI(request: request, response: response)
            controller.isModalInPresentation = presentProperties.isModalInPresentation
            controller.modalPresentationStyle = presentProperties.modalPresentationStyle
            controller.modalTransitionStyle = presentProperties.modalTransitionStyle
            let navigationController = UINavigationController(rootViewController: controller)
            self.navigationController.present(navigationController, animated: true)
        }
    }

}
