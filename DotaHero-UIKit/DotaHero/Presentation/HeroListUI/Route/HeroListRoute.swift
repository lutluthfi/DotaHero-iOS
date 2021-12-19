//
//  HeroListRoute.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 20/12/21.
//

import UIKit

public protocol HeroListRoute: AnyObject {
    func presentSortUI(
        request: SortViewModelRequest,
        response: SortViewModelResponse
    )
    func pushToHeroDetailUI(request: HeroDetailViewModelRequest)
}

public final class HeroListRouteImpl {
    let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension HeroListRouteImpl: HeroListRoute {
    public func presentSortUI(
        request: SortViewModelRequest,
        response: SortViewModelResponse
    ) {
        let controller = SortUIBuilder(navigationController, request: request, response: response).build()
        navigationController.present(controller, animated: true)
    }
    
    public func pushToHeroDetailUI(request: HeroDetailViewModelRequest) {
        let controller = HeroDetailUIBuilder(navigationController, request: request).build()
        navigationController.pushViewController(controller, animated: true)
    }
}
