//
//  HeroListViewModel.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import DTDomainModule
import RxRelay
import RxSwift

enum HeroListViewModelResponse {
}

protocol HeroListViewModelDelegate: AnyObject {
}

public struct HeroListViewModelRequest {
}

protocol HeroListViewModelInput {
    func viewDidLoad()
    func doSelect(heroRole: String)
    func doSelect(hero: HeroDomain)
    func presentSortUI()
}

protocol HeroListViewModelOutput {
    var showedHeroStats: BehaviorRelay<[HeroDomain]> { get }
}

protocol HeroListViewModel: HeroListViewModelInput, HeroListViewModelOutput { }

final class HeroListViewModelImpl: HeroListViewModel {
    weak var delegate: HeroListViewModelDelegate?
    let request: HeroListViewModelRequest
    let route: HeroListRoute

    let fetchAllHeroStatUseCase: FetchAllHeroStatUseCase

    let disposeBag = DisposeBag()
    var _heroStats: [HeroDomain] = []
    var _selectedHeroRole: String = "All"

    let showedHeroStats = BehaviorRelay<[HeroDomain]>(value: [])
    
    init(
        request: HeroListViewModelRequest,
        route: HeroListRoute,
        fetchAllHeroStatUseCase: FetchAllHeroStatUseCase
    ) {
        self.request = request
        self.route = route
        self.fetchAllHeroStatUseCase = fetchAllHeroStatUseCase
    }
}

extension HeroListViewModelImpl {
    func viewDidLoad() {
        let request = FetchAllHeroStatUseCaseRequest()
        fetchAllHeroStatUseCase
            .execute(request)
            .subscribe(onNext: { [unowned self] response in
                _heroStats = response.heroStats
                showedHeroStats.accept(response.heroStats)
            })
            .disposed(by: disposeBag)
    }
    
    func doSelect(heroRole: String) {
        guard heroRole.caseInsensitiveCompare("all") != .orderedSame else {
            showedHeroStats.accept(_heroStats)
            return
        }
        let filterHeroStats = _heroStats.filter({ $0.roles.contains(heroRole) })
        showedHeroStats.accept(filterHeroStats)
    }
    
    func doSelect(hero: HeroDomain) {
        let similarHeroStats: Array<HeroDomain>.SubSequence
        let samePrimaryAttributeHeroes = _heroStats
            .filter { hero -> Bool in
                let heroPrimaryAttr: String = hero.primaryAttribute
                let selectedHeroPrimaryAttr: String = hero.primaryAttribute
                return heroPrimaryAttr.caseInsensitiveCompare(selectedHeroPrimaryAttr) == .orderedSame
            }
        switch hero.primaryAttribute.lowercased() {
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
            similarHeroStats = Array<HeroDomain>.SubSequence()
        }
        let request = HeroDetailViewModelRequest(
            hero: hero,
            similarHeroes: Array(similarHeroStats)
        )
        route.pushToHeroDetailUI(request: request)
    }
    
    func presentSortUI() {
        let request = SortViewModelRequest()
        let response = SortViewModelResponse()
        response
            .selectedFactor
            .map({ [weak self] (factor) -> [HeroDomain] in
                guard let self = self else {
                    return []
                }
                let _heroStats = self.showedHeroStats.value
                let sortedHeroStats = _heroStats.sortedByFactor(factor)
                return sortedHeroStats
            })
            .bind(to: showedHeroStats)
            .disposed(by: disposeBag)
        route.presentSortUI(request: request, response: response)
    }
}
