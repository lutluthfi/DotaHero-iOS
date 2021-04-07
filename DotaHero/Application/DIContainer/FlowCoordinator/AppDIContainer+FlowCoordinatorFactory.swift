//
//  AppDIContainer+FlowCoordinatorFactory.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import UIKit

extension AppDIContainer: FlowCoordinatorFactory {
    
    public func makeBrowseFlowCoordinator() -> BrowseFlowCoordinator {
        return DefaultBrowseFlowCoordinator(navigationController: self.navigationController, factory: self)
    }
    
}
