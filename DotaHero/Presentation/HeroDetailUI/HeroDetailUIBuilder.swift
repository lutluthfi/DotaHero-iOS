//
//  HeroDetailUIBuilder.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 20/12/21.
//

import UIKit

public struct HeroDetailUIBuilder {
    private let controller: HeroDetailController
    
    public init(
        _ navigationController: UINavigationController,
        request: HeroDetailViewModelRequest
    ) {
        let route = HeroDetailRouteImpl(navigationController: navigationController)
        let viewModel = HeroDetailViewModelImpl(request: request, route: route)
        self.controller = HeroDetailController.create(with: viewModel)
    }
    
    func build() -> UIViewController {
        return controller
    }
}
