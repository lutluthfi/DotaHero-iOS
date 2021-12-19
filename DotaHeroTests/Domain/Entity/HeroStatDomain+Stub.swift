//
//  HeroDomain+Stub.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import Foundation
@testable import DEV_Dota_Hero

extension HeroDomain {
    
    static var stubElement: HeroDomain {
        let now = Date().toInt64()
        return HeroDomain(realmID: "1",
                              createdAt: now,
                              updatedAt: now,
                              attackType: "Melee",
                              baseAttackMax: 33,
                              baseAttackMin: 29,
                              baseArmor: -1,
                              baseHealth: 200,
                              baseMana: 75,
                              heroName: "Anti-Mage",
                              image: "/apps/dota2/images/heroes/antimage_full.png?",
                              moveSpeed: 310,
                              primaryAttribute: "agi",
                              roles:["Carry",
                                     "Escape",
                                     "Nuker"])
    }
    
}
