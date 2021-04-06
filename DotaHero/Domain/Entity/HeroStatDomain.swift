//
//  HeroStatDomain.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import Foundation

public struct HeroStatDomain {
    
    public let realmID: String
    public let createdAt: Int64
    public let updatedAt: Int64
    public let attackType: String
    public let baseAttackMax: Int
    public let baseAttackMin: Int
    public let baseArmor: Double
    public let baseHealth: Int
    public let baseMana: Int
    public let heroName: String
    public let moveSpeed: Int
    public let primaryAttribute: String
    public let roles: [String]
    
}

extension HeroStatDomain: Equatable {
    
    public static func == (lhs: HeroStatDomain, rhs: HeroStatDomain) -> Bool {
        return lhs.realmID == rhs.realmID
    }
    
}
