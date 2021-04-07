//
//  BSListViewModel.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation
import RxSwift

// MARK: BSListViewModelResponse
enum BSListViewModelResponse {
}

// MARK: BSListViewModelDelegate
protocol BSListViewModelDelegate: class {
}

// MARK: BSListViewModelRequestValue
public struct BSListViewModelRequestValue {
}

// MARK: BSListViewModelRoute
public struct BSListViewModelRoute {
}

// MARK: BSListViewModelInput
protocol BSListViewModelInput {

    func viewDidLoad()
    func doSelect(heroRole: String)

}

// MARK: BSListViewModelOutput
protocol BSListViewModelOutput {

    var showedHeroStats: PublishSubject<[HeroStatDomain]> { get }
    
}

// MARK: BSListViewModel
protocol BSListViewModel: BSListViewModelInput, BSListViewModelOutput { }

// MARK: DefaultBSListViewModel
final class DefaultBSListViewModel: BSListViewModel {

    // MARK: DI Variable
    weak var delegate: BSListViewModelDelegate?
    let requestValue: BSListViewModelRequestValue
    let route: BSListViewModelRoute

    // MARK: UseCase Variable
    let fetchAllHeroStatUseCase: FetchAllHeroStatUseCase

    // MARK: Common Variable
    let disposeBag = DisposeBag()
    var _heroStats: [HeroStatDomain] = []
    var _selectedHeroRole: String = "All"

    // MARK: Output ViewModel
    let showedHeroStats = PublishSubject<[HeroStatDomain]>()

    // MARK: Init Function
    init(requestValue: BSListViewModelRequestValue,
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
                self.showedHeroStats.onNext(response.heroStats)
            })
            .disposed(by: self.disposeBag)
    }
    
    func doSelect(heroRole: String) {
        guard heroRole.caseInsensitiveCompare("all") != .orderedSame else {
            self.showedHeroStats.onNext(self._heroStats)
            return
        }
        let filterHeroStats = self._heroStats.filter { $0.roles.contains(heroRole) }
        self.showedHeroStats.onNext(filterHeroStats)
    }
    
}
