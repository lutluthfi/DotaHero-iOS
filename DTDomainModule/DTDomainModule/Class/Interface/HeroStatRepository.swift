//
//  HeroStatRepository.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import RxAlamofire
import RxSwift

public protocol HeroStatRepository {
    
    func fetchHeroStats(
        in storage: StoragePoint
    ) -> Observable<([HeroDomain], NetworkProgress?)>
    
    func insertHeroStats(
        _ collections: [HeroDomain],
        into storage: StoragePoint
    ) -> Observable<[HeroDomain]>
    
}
