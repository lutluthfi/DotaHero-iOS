//
//  HeroStatRepositoryImpl.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import DTDomainModule
import RxSwift

public class HeroStatRepositoryImpl {
    
    let localStorage: LocalHeroStatStorage
    let remoteStorage: RemoteHeroStatStorage
    
    public init(
        localStorage: LocalHeroStatStorage,
        remoteStorage: RemoteHeroStatStorage
    ) {
        self.localStorage = localStorage
        self.remoteStorage = remoteStorage
    }
    
}

extension HeroStatRepositoryImpl: HeroStatRepository {
    
    public func fetchHeroStats(in storage: StoragePoint) -> Observable<([HeroDomain], NetworkProgress?)> {
        switch storage {
        case .realm:
            return self.localStorage
                .fetchHeroStats()
                .flatMap { (observable) -> Observable<([HeroDomain], NetworkProgress?)> in
                    let objectsPart: [HeroDomain] = observable
                    let progressPart: NetworkProgress? = nil
                    let _observable = (objectsPart, progressPart)
                    return .just(_observable)
                }
        case .remote:
            return self.remoteStorage
                .fetchHeroStats()
                .flatMap { (observable) -> Observable<([HeroDomain], NetworkProgress?)> in
                    let objectsPart: [HeroDomain] = observable.0
                    let progressPart: NetworkProgress? = observable.1
                    let _observable = (objectsPart, progressPart)
                    return .just(_observable)
                }
        }
    }
    
    public func insertHeroStats(_ collections: [HeroDomain],
                                into storage: StoragePoint) -> Observable<[HeroDomain]> {
        switch storage {
        case .realm:
            return self.localStorage.insertHeroStats(collections)
        case .remote:
            return StoragePoint.makeRemoteStorageNotSupported(class: HeroStatRepository.self,
                                                              function: "insertHeroStats()",
                                                              object: [HeroDomain].self)
        }
    }
    
}
