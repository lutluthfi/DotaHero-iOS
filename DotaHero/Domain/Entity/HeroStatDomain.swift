//
//  HeroStatDomain.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import Foundation
import RxDataSources

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
    public let image: String
    public let moveSpeed: Int
    public let primaryAttribute: String
    public let roles: [String]
    
}

extension HeroStatDomain: Equatable {
    
    public static func == (lhs: HeroStatDomain, rhs: HeroStatDomain) -> Bool {
        return lhs.realmID == rhs.realmID
    }
    
}

extension HeroStatDomain: IdentifiableType {
    
    public typealias Identity = String
    
    public var identity: String {
        return self.realmID
    }
    
}

public extension Array where Element == HeroStatDomain {
    
    func populateRoles() -> [String] {
        var roles: [String] = ["All"]
        for role in self.flatMap({ $0.roles }) {
            if !roles.contains(role) {
                roles.append(role)
            }
        }
        return roles.sorted()
    }
    
}
