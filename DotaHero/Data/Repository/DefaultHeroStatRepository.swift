//
//  DefaultHeroStatRepository.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import RxSwift

public class DefaultHeroStatRepository {
    
    let localStorage: LocalHeroStatStorage
    let remoteStorage: RemoteHeroStatStorage
    
    public init(localStorage: LocalHeroStatStorage, remoteStorage: RemoteHeroStatStorage) {
        self.localStorage = localStorage
        self.remoteStorage = remoteStorage
    }
    
}

extension DefaultHeroStatRepository: HeroStatRepository {
    
    public func fetchHeroStats(in storage: StoragePoint) -> Observable<([HeroStatDomain], NetworkProgress?)> {
        switch storage {
        case .realm:
            return self.localStorage
                .fetchHeroStats()
                .flatMap { (observable) -> Observable<([HeroStatDomain], NetworkProgress?)> in
                    let objectsPart: [HeroStatDomain] = observable
                    let progressPart: NetworkProgress? = nil
                    let _observable = (objectsPart, progressPart)
                    return .just(_observable)
                }
        case .remote:
            return self.remoteStorage
                .fetchHeroStats()
                .flatMap { (observable) -> Observable<([HeroStatDomain], NetworkProgress?)> in
                    let objectsPart: [HeroStatDomain] = observable.0
                    let progressPart: NetworkProgress? = observable.1
                    let _observable = (objectsPart, progressPart)
                    return .just(_observable)
                }
        }
    }
    
    public func insertHeroStats(_ collections: [HeroStatDomain],
                                into storage: StoragePoint) -> Observable<[HeroStatDomain]> {
        switch storage {
        case .realm:
            return self.localStorage.insertHeroStats(collections)
        case .remote:
            return StoragePoint.makeRemoteStorageNotSupported(class: HeroStatRepository.self,
                                                              function: "insertHeroStats()",
                                                              object: [HeroStatDomain].self)
        }
    }
    
}
