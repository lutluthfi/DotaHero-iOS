//
//  AppFlowCoordinator.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/04/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

// MARK: AppFlowCoordinator
protocol AppFlowCoordinator {
    func start(with instructor: AppFlowCoordinatorInstructor)
}

// MARK: AppFlowCoordinatorInstructor
enum AppFlowCoordinatorInstructor {
    case `default`
}

// MARK: DefaultAppFlowCoordinator
final class DefaultAppFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let flowFactory: FlowCoordinatorFactory

    // MARK: Init Funciton
    init(navigationController: UINavigationController, factory: PresentationFactory) {
        self.navigationController = navigationController
        self.flowFactory = factory
    }
    
}

extension DefaultAppFlowCoordinator: AppFlowCoordinator {
    
    func start(with instructor: AppFlowCoordinatorInstructor) {
        switch instructor {
        case .default:
            let requestValue = BSListViewModelRequestValue()
            self.flowFactory.makeBrowseFlowCoordinator().start(with: .pushToListUI(requestValue))
        }
    }
    
}
