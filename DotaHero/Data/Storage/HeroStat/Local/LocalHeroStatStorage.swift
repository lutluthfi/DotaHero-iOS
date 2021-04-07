//
//  LocalHeroStatStorage.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import Foundation
import RxSwift

public protocol LocalHeroStatStorage {
    
    func fetchHeroStats() -> Observable<[HeroStatDomain]>
    
    func insertHeroStats(_ collections: [HeroStatDomain]) -> Observable<[HeroStatDomain]>
    
}

public final class DefaultLocalHeroStatStorage {
    
    let realmStorage: RealmStorageShared
    
    public init(realmStorage: RealmStorageShared = RealmStorage.shared) {
        self.realmStorage = realmStorage
    }
    
}

extension DefaultLocalHeroStatStorage: LocalHeroStatStorage {
    
    public func fetchHeroStats() -> Observable<[HeroStatDomain]> {
        return Observable.create { [unowned self] (observer) -> Disposable in
            let objects = self.realmStorage.realm.objects(HeroStatRealm.self)
            let domains = Array(objects)
                .sorted { $0.heroName < $1.heroName }
                .map { $0.toDomain() }
            observer.onNext(domains)
            observer.onCompleted()
            return Disposables.create()
        }.observeOn(ConcurrentMainScheduler.instance)
    }
    
    public func insertHeroStats(_ collections: [HeroStatDomain]) -> Observable<[HeroStatDomain]> {
        return Observable.create { [unowned self] (observer) -> Disposable in
            do {
                self.realmStorage.realm.beginWrite()
                let objects = collections.map { $0.toRealm() }
                self.realmStorage.realm.add(objects, update: .all)
                try self.realmStorage.realm.commitWrite()
                observer.onNext(collections)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }.observeOn(ConcurrentMainScheduler.instance)
    }
    
}
