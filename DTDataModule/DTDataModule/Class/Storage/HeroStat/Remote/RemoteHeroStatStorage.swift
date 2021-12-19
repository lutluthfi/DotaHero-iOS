//
//  RemoteHeroStatStorage.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import DTDomainModule
import RxAlamofire
import RxSwift

public protocol RemoteHeroStatStorage {
    
    func fetchHeroStats() -> Observable<([HeroDomain], NetworkProgress)>
    
}

public final class RemoteHeroStatStorageImpl {
    
    let openDotaNetworkService: OpenDotaNetworkService
    
    public init(openDotaNetworkService: OpenDotaNetworkService) {
        self.openDotaNetworkService = openDotaNetworkService
    }
    
}

extension RemoteHeroStatStorageImpl: RemoteHeroStatStorage {
    
    public func fetchHeroStats() -> Observable<([HeroDomain], NetworkProgress)> {
        let request = FetchHeroStatDTO.Request()
        return self.openDotaNetworkService
            .fetchHeroStats(with: request)
            .flatMap { (observable) -> Observable<([HeroDomain], NetworkProgress)> in
                let domainsPart = observable.0.map { $0.toDomain() }
                let progressPart = observable.1
                let _observable = (domainsPart, progressPart)
                return .just(_observable)
            }
    }
    
}
