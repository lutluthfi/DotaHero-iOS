//
//  AppDIContainer+UseCaseFactory.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import Foundation

extension AppDIContainer: UseCaseFactory {
    
    public func makeFetchAllHeroStatUseCase() -> FetchAllHeroStatUseCase {
        return DefaultFetchAllHeroStatUseCase(repository: self.makeHeroStatRepository())
    }
    
}
