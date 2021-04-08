//
//  BSDetailViewModel.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation
import RxSwift

// MARK: BSDetailViewModelResponse
enum BSDetailViewModelResponse {
}

// MARK: BSDetailViewModelDelegate
protocol BSDetailViewModelDelegate: class {
}

// MARK: BSDetailViewModelRequestValue
public struct BSDetailViewModelRequestValue {
    
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

    var showedHeroStatAndSimilarHeroes: PublishSubject<(HeroStatDomain, [HeroStatDomain])> { get }
    
}

// MARK: BSDetailViewModel
protocol BSDetailViewModel: BSDetailViewModelInput, BSDetailViewModelOutput { }

// MARK: DefaultBSDetailViewModel
final class DefaultBSDetailViewModel: BSDetailViewModel {

    // MARK: DI Variable
    weak var delegate: BSDetailViewModelDelegate?
    let requestValue: BSDetailViewModelRequestValue
    let route: BSDetailViewModelRoute

    // MARK: UseCase Variable


    // MARK: Common Variable
    

    // MARK: Output ViewModel
    let showedHeroStatAndSimilarHeroes = PublishSubject<(HeroStatDomain, [HeroStatDomain])>()

    // MARK: Init Function
    init(requestValue: BSDetailViewModelRequestValue,
         route: BSDetailViewModelRoute) {
        self.requestValue = requestValue
        self.route = route
    }
    
}

// MARK: Input ViewModel
extension DefaultBSDetailViewModel {
    
    func viewDidLoad() {
        let element = (self.requestValue.heroStat, self.requestValue.similarHeroStats)
        self.showedHeroStatAndSimilarHeroes.onNext(element)
    }
    
}
