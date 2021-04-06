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
}

// MARK: BrowseFlowCoordinator
public protocol BrowseFlowCoordinator {
    func start(with instructor: BrowseFlowCoordinatorInstructor)
}

// MARK: BrowseFlowCoordinatorInstructor
public enum BrowseFlowCoordinatorInstructor {
    
}

// MARK: DefaultBrowseFlowCoordinator
public final class DefaultBrowseFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let factory: BrowseFlowCoordinatorFactory

    // MARK: Init Funciton
    public init(navigationController: UINavigationController, factory: BrowseFlowCoordinatorFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
}

extension DefaultBrowseFlowCoordinator: BrowseFlowCoordinator {
    
    public func start(with instructor: BrowseFlowCoordinatorInstructor) {
    }
    
}
