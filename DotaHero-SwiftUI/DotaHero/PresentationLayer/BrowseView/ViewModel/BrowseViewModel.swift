//
//  BrowseViewModel.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 15/11/21.
//

import Combine
import DTCommonModule
import DTDomainModule
import RxSwift

final class BrowseViewModel: ObservableObject {
    
    // DI Variable
    let fetchAllHeroStatUseCase: FetchAllHeroStatUseCase
    
    // ViewModel Variable
    let disposeBag = DisposeBag()
    
    // ViewModelOutput
    @Published
    private(set) var heroesPublished: [HeroDomain] = []
    @Published
    private(set) var heroByRolePublished: [String: [HeroDomain]] = [:]
    
    init(fetchAllHeroStatUseCase: FetchAllHeroStatUseCase) {
        self.fetchAllHeroStatUseCase = fetchAllHeroStatUseCase
    }
    
}

    // ViewModelInput
extension BrowseViewModel {
    
    private func loadHeroes(
        completion: @escaping (FetchAllHeroStatUseCaseResponse) -> Void
    ) {
        let request = FetchAllHeroStatUseCaseRequest()
        fetchAllHeroStatUseCase
            .execute(request)
            .subscribe(onNext: { [weak self] (response) in
                let heroes: [HeroDomain] = response.heroStats
                self?.heroesPublished = heroes
                completion(response)
            })
            .disposed(by: disposeBag)
    }
    
    func loadHeroesByRole() {
        loadHeroes { [weak self] (respose) in
            guard let self = self else {
                return
            }
            let heroes: [HeroDomain] = respose.heroStats
            let roles: [String] = heroes.flatMap { $0.roles }
            
            var res: [String: [HeroDomain]] = [:]
            for role in roles {
                res[role] = heroes.filter(roles: [role])
            }
            self.heroByRolePublished = res
        }
    }
    
}
