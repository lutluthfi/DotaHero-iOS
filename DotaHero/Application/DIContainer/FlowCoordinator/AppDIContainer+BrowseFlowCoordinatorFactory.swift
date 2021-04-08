//
//  AppDIContainer+BrowseFlowCoordinatorFactory.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import UIKit

extension AppDIContainer: BrowseFlowCoordinatorFactory { }

// MARK: BSDetailUI
extension AppDIContainer {
    
    public func makeBSDetailController(requestValue: BSDetailViewModelRequestValue,
                                       route: BSDetailViewModelRoute) -> UIViewController {
        let viewModel = self.makeBSDetailViewModel(requestValue: requestValue, route: route)
        return BSDetailController.create(with: viewModel)
    }
    
    private func makeBSDetailViewModel(requestValue: BSDetailViewModelRequestValue,
                                       route: BSDetailViewModelRoute) -> BSDetailViewModel {
        return DefaultBSDetailViewModel(requestValue: requestValue, route: route)
    }
    
}

// MARK: BSListUI
extension AppDIContainer {
    
    public func makeBSListController(requestValue: BSListViewModelRequestValue,
                                     route: BSListViewModelRoute) -> UIViewController {
        let viewModel = self.makeBSListViewModel(requestValue: requestValue, route: route)
        return BSListController.create(with: viewModel)
    }
    
    private func makeBSListViewModel(requestValue: BSListViewModelRequestValue,
                                     route: BSListViewModelRoute) -> BSListViewModel {
        return DefaultBSListViewModel(requestValue: requestValue,
                                      route: route,
                                      fetchAllHeroStatUseCase: self.makeFetchAllHeroStatUseCase())
    }
    
}
