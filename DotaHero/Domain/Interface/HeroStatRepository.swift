//
//  HeroStatRepository.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import RxAlamofire
import RxSwift

public protocol HeroStatRepository {
    
    func fetchHeroStats(in storage: StoragePoint) -> Observable<([HeroStatDomain], NetworkProgress?)>
    
    func insertHeroStats(_ collections: [HeroStatDomain], into storage: StoragePoint) -> Observable<[HeroStatDomain]>
    
}
