//
//  HeroDomainStub.swift
//  DTDomainModule
//
//  Created by Arif Luthfiansyah on 16/11/21.
//

import DTCommonModule

public struct HeroDomainStub {
    
    public static var single: HeroDomain {
        let today = Date()
        let hero = HeroDomain(
            realmID: UUID().uuidString,
            createdAt: today.toInt64(),
            updatedAt: today.toInt64(),
            attackType: "Melee",
            baseAttackMax: 33,
            baseAttackMin: 29,
            baseArmor: 0,
            baseHealth: 200,
            baseMana: 75,
            heroName: "Anti-Mage",
            image: "https://api.opendota.com/apps/dota2/images/dota_react/heroes/antimage.png?",
            isFavorite: false,
            moveSpeed: 310,
            primaryAttribute: "agi",
            roles: [
                "Carry",
                "Escape",
                "Nuker"
            ]
        )
        return hero
    }
    
    public static func collection(count: Int) -> [HeroDomain] {
        var res: [HeroDomain] = []
        for _ in 0...count {
            let newElement: HeroDomain = HeroDomainStub.single
            res.append(newElement)
        }
        return res
    }
    
}
