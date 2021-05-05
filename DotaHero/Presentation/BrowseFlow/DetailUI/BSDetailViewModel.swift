//
//  BSDetailViewModel.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation
import RxRelay
import RxSwift

// MARK: BSDetailViewModelResponse
enum BSDetailViewModelResponse {
}

// MARK: BSDetailViewModelDelegate
protocol BSDetailViewModelDelegate: class {
}

// MARK: BSDetailViewModelRequest
public struct BSDetailViewModelRequest {
    public let heroStat: HeroStatDomain
    public let similarHeroStats: [HeroStatDomain]
}

// MARK: BSDetailViewModelRoute
public struct BSDetailViewModelRoute {
}

// MARK: BSDetailViewModelInput
protocol BSDetailViewModelInput {
    func viewDidLoad()
}

// MARK: BSDetailViewModelOutput
protocol BSDetailViewModelOutput {
    var showedHeroStat: PublishRelay<HeroStatDomain> { get }
}

// MARK: BSDetailViewModel
protocol BSDetailViewModel: BSDetailViewModelInput, BSDetailViewModelOutput { }

// MARK: DefaultBSDetailViewModel
final class DefaultBSDetailViewModel: BSDetailViewModel {

    // MARK: DI Variable
    weak var delegate: BSDetailViewModelDelegate?
    let requestValue: BSDetailViewModelRequest
    let route: BSDetailViewModelRoute

    // MARK: UseCase Variable


    // MARK: Common Variable
    

    // MARK: Output ViewModel
    let showedHeroStat = PublishRelay<HeroStatDomain>()

    // MARK: Init Function
    init(requestValue: BSDetailViewModelRequest,
         route: BSDetailViewModelRoute) {
        self.requestValue = requestValue
        self.route = route
    }
    
}

// MARK: Input ViewModel
extension DefaultBSDetailViewModel {
    
    func viewDidLoad() {
        let heroStat = self.requestValue.heroStat
        self.showedHeroStat.accept(heroStat)
    }
    
}
