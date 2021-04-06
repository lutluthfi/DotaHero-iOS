//
//  AppDIContainer+RepositoryFactory.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import Foundation

extension AppDIContainer: RepositoryFactory {
    
    public func makeHeroStatRepository() -> HeroStatRepository {
        return DefaultHeroStatRepository(localStorage: self.localHeroStatStorage,
                                         remoteStorage: self.remoteHeroStatStorage)
    }
    
}
