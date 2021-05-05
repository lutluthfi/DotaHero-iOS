//
//  BSListViewModel.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation
import RxRelay
import RxSwift

// MARK: BSListViewModelResponse
enum BSListViewModelResponse {
}

// MARK: BSListViewModelDelegate
protocol BSListViewModelDelegate: class {
}

// MARK: BSListViewModelRequest
public struct BSListViewModelRequest {
}

// MARK: BSListViewModelRoute
public struct BSListViewModelRoute {
    var presentBSSortUI: ((BSSortViewModelRequest, BSSortViewModelResponse) -> Void)?
    var pushToBSDetailUI: ((BSDetailViewModelRequest) -> Void)?
}

// MARK: BSListViewModelInput
protocol BSListViewModelInput {
    func viewDidLoad()
    func doSelect(heroRole: String)
    func doSelect(heroStat: HeroStatDomain)
    func presentBSSortUI()
}

// MARK: BSListViewModelOutput
protocol BSListViewModelOutput {
    var showedHeroStats: BehaviorRelay<[HeroStatDomain]> { get }
}

// MARK: BSListViewModel
protocol BSListViewModel: BSListViewModelInput, BSListViewModelOutput { }

// MARK: DefaultBSListViewModel
final class DefaultBSListViewModel: BSListViewModel {

    // MARK: DI Variable
    weak var delegate: BSListViewModelDelegate?
    let requestValue: BSListViewModelRequest
    let route: BSListViewModelRoute

    // MARK: UseCase Variable
    let fetchAllHeroStatUseCase: FetchAllHeroStatUseCase

    // MARK: Common Variable
    let disposeBag = DisposeBag()
    var _heroStats: [HeroStatDomain] = []
    var _selectedHeroRole: String = "All"

    // MARK: Output ViewModel
    let showedHeroStats = BehaviorRelay<[HeroStatDomain]>(value: [])

    // MARK: Init Function
    init(requestValue: BSListViewModelRequest,
         route: BSListViewModelRoute,
         fetchAllHeroStatUseCase: FetchAllHeroStatUseCase) {
        self.requestValue = requestValue
        self.route = route
        self.fetchAllHeroStatUseCase = fetchAllHeroStatUseCase
    }
    
}

// MARK: Input ViewModel
extension DefaultBSListViewModel {
    
    func viewDidLoad() {
        let request = FetchAllHeroStatUseCaseRequest()
        self.fetchAllHeroStatUseCase
            .execute(request)
            .subscribe(onNext: { [unowned self] response in
                self._heroStats = response.heroStats
                self.showedHeroStats.accept(response.heroStats)
            })
            .disposed(by: self.disposeBag)
    }
    
    func doSelect(heroRole: String) {
        guard heroRole.caseInsensitiveCompare("all") != .orderedSame else {
            self.showedHeroStats.accept(self._heroStats)
            return
        }
        let filterHeroStats = self._heroStats.filter({ $0.roles.contains(heroRole) })
        self.showedHeroStats.accept(filterHeroStats)
    }
    
    func doSelect(heroStat: HeroStatDomain) {
        let similarHeroStats: Array<HeroStatDomain>.SubSequence
        let samePrimaryAttributeHeroes = self._heroStats
            .filter({ $0.primaryAttribute.caseInsensitiveCompare(heroStat.primaryAttribute) == .orderedSame })
        switch heroStat.primaryAttribute.lowercased() {
        case "agi":
            similarHeroStats = samePrimaryAttributeHeroes
                .sorted(by: { $0.moveSpeed > $1.moveSpeed })
                .prefix(3)
        case "int":
            similarHeroStats = samePrimaryAttributeHeroes
                .sorted(by: { $0.baseMana > $1.baseMana })
                .prefix(3)
        case "str":
            similarHeroStats = samePrimaryAttributeHeroes
                .sorted(by: { $0.baseAttackMax > $1.baseAttackMax })
                .prefix(3)
        default:
            similarHeroStats = Array<HeroStatDomain>.SubSequence()
        }
        let requestValue = BSDetailViewModelRequest(heroStat: heroStat, similarHeroStats: Array(similarHeroStats))
        self.route.pushToBSDetailUI?(requestValue)
    }
    
    func presentBSSortUI() {
        let request = BSSortViewModelRequest()
        let response = BSSortViewModelResponse()
        response
            .selectedFactor
            .map({ (factor) -> [HeroStatDomain] in
                let _heroStats = self.showedHeroStats.value
                let sortedHeroStats = _heroStats.sortedByFactor(factor)
                return sortedHeroStats
            })
            .bind(to: self.showedHeroStats)
            .disposed(by: self.disposeBag)
        self.route.presentBSSortUI?(request, response)
    }
    
}
