//
//  HeroDetailRoute.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 20/12/21.
//

import UIKit

public protocol HeroDetailRoute: AnyObject {
}

public final class HeroDetailRouteImpl {
    let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension HeroDetailRouteImpl: HeroDetailRoute {
    
}
