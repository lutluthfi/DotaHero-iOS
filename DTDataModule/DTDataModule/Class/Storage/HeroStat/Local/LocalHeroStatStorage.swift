//
//  LocalHeroStatStorage.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import DTDomainModule
import RxSwift

public protocol LocalHeroStatStorage {
    
    func fetchHeroStats() -> Observable<[HeroDomain]>
    
    func insertHeroStats(_ collections: [HeroDomain]) -> Observable<[HeroDomain]>
    
}

public final class LocalHeroStatStorageImpl {
    
    let realmStorage: RealmStorageShared
    
    public init(realmStorage: RealmStorageShared = RealmStorage.shared) {
        self.realmStorage = realmStorage
    }
    
}

extension LocalHeroStatStorageImpl: LocalHeroStatStorage {
    
    public func fetchHeroStats() -> Observable<[HeroDomain]> {
        return Observable.create { [unowned self] (observer) -> Disposable in
            let objects = self.realmStorage.realm.objects(HeroStatRealm.self)
            let domains = Array(objects).map { $0.toDomain() }
            observer.onNext(domains)
            observer.onCompleted()
            return Disposables.create()
        }.observe(on: ConcurrentMainScheduler.instance)
    }
    
    public func insertHeroStats(_ collections: [HeroDomain]) -> Observable<[HeroDomain]> {
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
        }.observe(on: ConcurrentMainScheduler.instance)
    }
    
}
