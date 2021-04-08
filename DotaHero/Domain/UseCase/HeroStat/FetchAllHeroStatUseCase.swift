//
//  FetchAllHeroStatUseCase.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//  Copyright (c) 2021 All rights reserved.

import RxSwift

public struct FetchAllHeroStatUseCaseResponse {
    
    public let heroStats: [HeroStatDomain]
    public let progress: NetworkProgress?
    
}

public struct FetchAllHeroStatUseCaseRequest {
    
}

public protocol FetchAllHeroStatUseCase {
    
    func execute(_ request: FetchAllHeroStatUseCaseRequest) -> Observable<FetchAllHeroStatUseCaseResponse>

}

public final class DefaultFetchAllHeroStatUseCase {

    let repository: HeroStatRepository
    
    public init(repository: HeroStatRepository) {
        self.repository = repository
    }

}

extension DefaultFetchAllHeroStatUseCase: FetchAllHeroStatUseCase {

    public func execute(_ request: FetchAllHeroStatUseCaseRequest) -> Observable<FetchAllHeroStatUseCaseResponse> {
        return self.repository
            .fetchHeroStats(in: .realm)
            .flatMap(self.fetchHeroStatsInRemoteWhenEmptyInLocal(_:))
            .flatMap(self.insertHeroStatsIntoLocal(_:))
            .flatMap { (observable) -> Observable<FetchAllHeroStatUseCaseResponse> in
                let heroStas = observable.0.sorted { $0.heroName < $1.heroName }
                let progress = observable.1
                let response = FetchAllHeroStatUseCaseResponse(heroStats: heroStas, progress: progress)
                return .just(response)
            }
    }
    
    func fetchHeroStatsInRemoteWhenEmptyInLocal(_ observable: ([HeroStatDomain], NetworkProgress?)) -> Observable<([HeroStatDomain], NetworkProgress?)> {
        guard observable.0.count > 100 else {
            return self.repository.fetchHeroStats(in: .remote)
        }
        let heroStatsPart: [HeroStatDomain] = observable.0
        let progressPart: NetworkProgress? = observable.1
        let element = (heroStatsPart, progressPart)
        return .just(element)
    }
    
    func insertHeroStatsIntoLocal(_ observable: ([HeroStatDomain], NetworkProgress?)) -> Observable<([HeroStatDomain], NetworkProgress?)> {
        let heroStatsPart: [HeroStatDomain] = observable.0
        let progressPart: NetworkProgress? = observable.1
        return self.repository
            .insertHeroStats(heroStatsPart, into: .realm)
            .flatMap { _ -> Observable<([HeroStatDomain], NetworkProgress?)> in
                let element = (heroStatsPart, progressPart)
                return .just(element)
            }
    }
    
}
