//
//  HeroDomain.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import Foundation
import RxDataSources

public struct HeroDomain {
    
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
    public let isFavorite: Bool
    public let moveSpeed: Int
    public let primaryAttribute: String
    public let roles: [String]
    
    public init(
        realmID: String,
        createdAt: Int64,
        updatedAt: Int64,
        attackType: String,
        baseAttackMax: Int,
        baseAttackMin: Int,
        baseArmor: Double,
        baseHealth: Int,
        baseMana: Int,
        heroName: String,
        image: String,
        isFavorite: Bool,
        moveSpeed: Int,
        primaryAttribute: String,
        roles: [String]
    ) {
        self.realmID = realmID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.attackType = attackType
        self.baseAttackMax = baseAttackMax
        self.baseAttackMin = baseAttackMin
        self.baseArmor = baseArmor
        self.baseHealth = baseHealth
        self.baseMana = baseMana
        self.heroName = heroName
        self.image = image
        self.isFavorite = isFavorite
        self.moveSpeed = moveSpeed
        self.primaryAttribute = primaryAttribute
        self.roles = roles
    }
    
}

public extension HeroDomain {
    
    static let sortByBaseAttack = "Base Attack (Lower Limit)"
    static let sortByBaseHealth = "Base Health"
    static let sortByBaseMana = "Base Mana"
    static let sortByBaseSpeed = "Base Speed"
    
}

extension HeroDomain: Equatable {
    
    public static func == (lhs: HeroDomain, rhs: HeroDomain) -> Bool {
        return lhs.realmID == rhs.realmID
    }
    
}

extension HeroDomain: IdentifiableType {
    
    public typealias Identity = String
    
    public var identity: String {
        return self.realmID
    }
    
}

public extension Array where Element == HeroDomain {
    
    func filter(roles: [String]) -> [HeroDomain] {
        let ans = filter({ $0.roles.contains(roles) })
        return ans
    }
    
    func populateRoles() -> [String] {
        var roles: [String] = ["All"]
        for role in flatMap({ $0.roles }) {
            if !roles.contains(role) {
                roles.append(role)
            }
        }
        return roles.sorted()
    }
    
    func sortedByFactor(_ factor: String) -> [HeroDomain] {
        switch factor {
        case HeroDomain.sortByBaseAttack:
            return self.sorted(by: { $0.baseAttackMin > $1.baseAttackMin })
        case HeroDomain.sortByBaseHealth:
            return self.sorted(by: { $0.baseHealth > $1.baseHealth })
        case HeroDomain.sortByBaseMana:
            return self.sorted(by: { $0.baseMana > $1.baseMana })
        case HeroDomain.sortByBaseSpeed:
            return self.sorted(by: { $0.moveSpeed > $1.moveSpeed })
        default:
            return self
        }
    }
    
}

private extension Array where Element == String {
    
    func contains(_ arr: [String]) -> Bool {
        if self.count >= arr.count {
            for element in self {
                if arr.contains(element) {
                    return true
                }
            }
        }
        if self.count <= arr.count {
            for element in arr {
                if self.contains(element) {
                    return true
                }
            }
        }
        return false
    }
    
}
