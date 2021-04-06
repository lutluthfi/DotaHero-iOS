//
//  RepositoryFactory.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import Foundation

public protocol RepositoryFactory {
    
    func makeHeroStatRepository() -> HeroStatRepository
    
}
