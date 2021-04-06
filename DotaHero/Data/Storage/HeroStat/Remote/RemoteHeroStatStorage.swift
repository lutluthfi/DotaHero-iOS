//
//  RemoteHeroStatStorage.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import RxAlamofire
import RxSwift

public protocol RemoteHeroStatStorage {
    
    func fetchHeroStats() -> Observable<([HeroStatDomain], NetworkProgress)>
    
}

public final class DefaultRemoteHeroStatStorage {
    
    let openDotaNetworkService: OpenDotaNetworkService
    
    public init(openDotaNetworkService: OpenDotaNetworkService) {
        self.openDotaNetworkService = openDotaNetworkService
    }
    
}

extension DefaultRemoteHeroStatStorage: RemoteHeroStatStorage {
    
    public func fetchHeroStats() -> Observable<([HeroStatDomain], NetworkProgress)> {
        let request = FetchHeroStatDTO.Request()
        return self.openDotaNetworkService
            .fetchHeroStats(with: request)
            .flatMap { (observable) -> Observable<([HeroStatDomain], NetworkProgress)> in
                let domainsPart = observable.0.map { $0.toDomain() }
                let progressPart = observable.1
                let _observable = (domainsPart, progressPart)
                return Observable.just(_observable)
            }
    }
    
}
