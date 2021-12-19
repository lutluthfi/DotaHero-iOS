//
//  FetchAllHeroStatUseCase.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import RxSwift

public struct FetchAllHeroStatUseCaseResponse {
    
    public let heroStats: [HeroDomain]
    public let progress: NetworkProgress?
    
}

public struct FetchAllHeroStatUseCaseRequest {
    
    public init() {
    }
    
}

public protocol FetchAllHeroStatUseCase {
    
    func execute(
        _ request: FetchAllHeroStatUseCaseRequest
    ) -> Observable<FetchAllHeroStatUseCaseResponse>

}

public final class FetchAllHeroStatUseCaseImpl {

    let repository: HeroStatRepository
    
    public init(repository: HeroStatRepository) {
        self.repository = repository
    }

}

extension FetchAllHeroStatUseCaseImpl: FetchAllHeroStatUseCase {

    public func execute(
        _ request: FetchAllHeroStatUseCaseRequest
    ) -> Observable<FetchAllHeroStatUseCaseResponse> {
        repository
            .fetchHeroStats(in: .realm)
            .flatMap(self.fetchHeroStatsInRemoteWhenEmptyInLocal(_:))
            .flatMap(self.insertHeroStatsIntoLocal(_:))
            .flatMap { (observable) -> Observable<FetchAllHeroStatUseCaseResponse> in
                let heroStas = observable.0.sorted { $0.heroName < $1.heroName }
                let progress = observable.1
                let response = FetchAllHeroStatUseCaseResponse(
                    heroStats: heroStas,
                    progress: progress
                )
                return .just(response)
            }
    }
    
    func fetchHeroStatsInRemoteWhenEmptyInLocal(
        _ observable: ([HeroDomain], NetworkProgress?)
    ) -> Observable<([HeroDomain], NetworkProgress?)> {
        guard observable.0.count > 100 else {
            return self.repository.fetchHeroStats(in: .remote)
        }
        let heroStatsPart: [HeroDomain] = observable.0
        let progressPart: NetworkProgress? = observable.1
        let element = (heroStatsPart, progressPart)
        return .just(element)
    }
    
    func insertHeroStatsIntoLocal(
        _ observable: ([HeroDomain], NetworkProgress?)
    ) -> Observable<([HeroDomain], NetworkProgress?)> {
        let heroStatsPart: [HeroDomain] = observable.0
        let progressPart: NetworkProgress? = observable.1
        return repository
            .insertHeroStats(heroStatsPart, into: .realm)
            .flatMap { _ -> Observable<([HeroDomain], NetworkProgress?)> in
                let element = (heroStatsPart, progressPart)
                return .just(element)
            }
    }
    
}
