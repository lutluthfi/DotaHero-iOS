//
//  DataModuleAssembly.swift
//  DTDataModule
//
//  Created by Arif Luthfiansyah on 15/11/21.
//

import Alamofire
import DTDomainModule
import Swinject

public final class DataModuleAssembly: Assembly {
    lazy var session = Session(
        configuration: sessionConfig,
        eventMonitors: [NetworkLogger()]
    )
    lazy var sessionConfig: URLSessionConfiguration = {
        let cofig = URLSessionConfiguration.default
        cofig.timeoutIntervalForResource = 60
        cofig.timeoutIntervalForRequest = 60
        return cofig
    }()
    
    lazy var openDotaService = OpenDotaNetworkService(session: session)
    
    public init() {
    }
    
    public func assemble(container: Container) {
        registerHeroStatStorage(in: container)
        registerHeroStatRepository(in: container)
    }
    
    func registerHeroStatStorage(in container: Container) {
        container.register(LocalHeroStatStorage.self) { r in
            let realmStorage: RealmStorageShared = RealmStorage.shared
            return LocalHeroStatStorageImpl(realmStorage: realmStorage)
        }
        container.register(RemoteHeroStatStorage.self) { r in
            RemoteHeroStatStorageImpl(openDotaNetworkService: self.openDotaService)
        }
    }
    
    func registerHeroStatRepository(in container: Container) {
        container.register(HeroStatRepository.self) { r in
            let localHeroStatStorage = r.resolve(LocalHeroStatStorage.self)!
            let remoteHeroStatStorage = r.resolve(RemoteHeroStatStorage.self)!
            return HeroStatRepositoryImpl(
                localStorage: localHeroStatStorage,
                remoteStorage: remoteHeroStatStorage
            )
        }
    }
}
