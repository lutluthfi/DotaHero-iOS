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
    public let isFavorite: Bool
    public let moveSpeed: Int
    public let primaryAttribute: String
    public let roles: [String]
    
}

public extension HeroStatDomain {
    
    static let sortByBaseAttack = "Base Attack (Lower Limit)"
    static let sortByBaseHealth = "Base Health"
    static let sortByBaseMana = "Base Mana"
    static let sortByBaseSpeed = "Base Speed"
    
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
    
    func filter(roles: [String]) -> [HeroStatDomain] {
        let ans = self.filter({ $0.roles.contains(roles) })
        return ans
    }
    
    func populateRoles() -> [String] {
        var roles: [String] = ["All"]
        for role in self.flatMap({ $0.roles }) {
            if !roles.contains(role) {
                roles.append(role)
            }
        }
        return roles.sorted()
    }
    
    func sortedByFactor(_ factor: String) -> [HeroStatDomain] {
        switch factor {
        case HeroStatDomain.sortByBaseAttack:
            return self.sorted(by: { $0.baseAttackMin > $1.baseAttackMin })
        case HeroStatDomain.sortByBaseHealth:
            return self.sorted(by: { $0.baseHealth > $1.baseHealth })
        case HeroStatDomain.sortByBaseMana:
            return self.sorted(by: { $0.baseMana > $1.baseMana })
        case HeroStatDomain.sortByBaseSpeed:
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
