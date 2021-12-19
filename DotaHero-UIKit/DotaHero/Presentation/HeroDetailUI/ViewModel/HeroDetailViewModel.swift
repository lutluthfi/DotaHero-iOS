//
//  HeroDetailViewModel.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import DTCommonModule
import DTDomainModule
import Foundation
import RxRelay
import RxSwift

enum HeroDetailViewModelResponse {
}

protocol HeroDetailViewModelDelegate: AnyObject {
}

public struct HeroDetailViewModelRequest {
    public let hero: HeroDomain
    public let similarHeroes: [HeroDomain]
}

protocol HeroDetailViewModelInput {
    func viewDidLoad()
}

protocol HeroDetailViewModelOutput {
    var rxEventShowHeroes: Observable<HeroDomain> { get }
}

protocol HeroDetailViewModel: HeroDetailViewModelInput, HeroDetailViewModelOutput { }

final class HeroDetailViewModelImpl: HeroDetailViewModel {
    
    weak var delegate: HeroDetailViewModelDelegate?
    let request: HeroDetailViewModelRequest
    let route: HeroDetailRoute
    
    @RxPublishRelay
    var rxEventShowHeroes: Observable<HeroDomain>
    
    init(
        request: HeroDetailViewModelRequest,
        route: HeroDetailRoute
    ) {
        self.request = request
        self.route = route
    }
    
}

extension HeroDetailViewModelImpl {
    func viewDidLoad() {
        let hero: HeroDomain = request.hero
        _rxEventShowHeroes.accept(hero)
    }
}
