//
//  HeroStatDomain+Stub.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import Foundation
@testable import DEV_Dota_Hero

extension HeroStatDomain {
    
    static var stubElement: HeroStatDomain {
        let now = Date().toInt64()
        return HeroStatDomain(realmID: "1",
                              createdAt: now,
                              updatedAt: now,
                              attackType: "Melee",
                              baseAttackMax: 33,
                              baseAttackMin: 29,
                              baseArmor: -1,
                              baseHealth: 200,
                              baseMana: 75,
                              heroName: "Anti-Mage",
                              moveSpeed: 310,
                              primaryAttribute: "agi",
                              roles:["Carry",
                                     "Escape",
                                     "Nuker"])
    }
    
}
