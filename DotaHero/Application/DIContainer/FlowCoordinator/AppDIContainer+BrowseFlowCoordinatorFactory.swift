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
    
    public func makeBSDetailController(request: BSDetailViewModelRequest,
                                       route: BSDetailViewModelRoute) -> UIViewController {
        let viewModel = self.makeBSDetailViewModel(requestValue: request, route: route)
        return BSDetailController.create(with: viewModel)
    }
    
    private func makeBSDetailViewModel(requestValue: BSDetailViewModelRequest,
                                       route: BSDetailViewModelRoute) -> BSDetailViewModel {
        return DefaultBSDetailViewModel(requestValue: requestValue, route: route)
    }
    
}

// MARK: BSListUI
extension AppDIContainer {
    
    public func makeBSListController(request: BSListViewModelRequest,
                                     route: BSListViewModelRoute) -> UIViewController {
        let viewModel = self.makeBSListViewModel(requestValue: request, route: route)
        return BSListController.create(with: viewModel)
    }
    
    private func makeBSListViewModel(requestValue: BSListViewModelRequest,
                                     route: BSListViewModelRoute) -> BSListViewModel {
        return DefaultBSListViewModel(requestValue: requestValue,
                                      route: route,
                                      fetchAllHeroStatUseCase: self.makeFetchAllHeroStatUseCase())
    }
    
}

// MARK: BSSortUI
extension AppDIContainer {
    
    public func makeBSSortController(request: BSSortViewModelRequest,
                                     response: BSSortViewModelResponse,
                                     route: BSSortViewModelRoute) -> UIViewController {
        let viewModel = self.makeBSSortViewModel(request: request, response: response, route: route)
        return BSSortController.create(with: viewModel)
    }
    
    private func makeBSSortViewModel(request: BSSortViewModelRequest,
                                     response: BSSortViewModelResponse,
                                     route: BSSortViewModelRoute) -> BSSortViewModel {
        return DefaultBSSortViewModel(request: request, response: response, route: route)
    }
    
}
