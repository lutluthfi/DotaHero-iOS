//
//  HeroListUIBuilder.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 20/12/21.
//

import DTCommonModule
import UIKit
import DTDomainModule

public struct HeroListUIBuilder {
    private let controller: HeroListController
    
    public init(
        _ navigationController: UINavigationController,
        request: HeroListViewModelRequest
    ) {
        let route = HeroListRouteImpl(navigationController: navigationController)
        let viewModel = HeroListViewModelImpl(
            request: request,
            route: route,
            fetchAllHeroStatUseCase: Dependency.resolve(FetchAllHeroStatUseCase.self)!
        )
        controller = HeroListController.create(with: viewModel)
    }
    
    func build() -> UIViewController {
        return controller
    }
}
