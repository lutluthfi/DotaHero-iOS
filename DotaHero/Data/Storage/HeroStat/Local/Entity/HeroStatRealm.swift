//
//  HeroStatRealm.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import RealmSwift

public class HeroStatRealm: Object {
    
    @objc
    dynamic public var realmID: String = ""
    @objc
    dynamic public var createdAt: Int64 = 0
    @objc
    dynamic public var updatedAt: Int64 = 0
    
    @objc
    dynamic public var attackType: String = ""
    @objc
    dynamic public var baseAttackMax: Int = 0
    @objc
    dynamic public var baseAttackMin: Int = 0
    @objc
    dynamic public var baseArmor: Double = 0
    @objc
    dynamic public var baseHealth: Int = 0
    @objc
    dynamic public var baseMana: Int = 0
    @objc
    dynamic public var heroName: String = ""
    @objc
    dynamic public var image: String = ""
    @objc
    dynamic public var isFavorite: Bool = false
    @objc
    dynamic public var moveSpeed: Int = 0
    @objc
    dynamic public var primaryAttribute: String = ""
    public var roles: List<String> = List()
    
    public override class func primaryKey() -> String? {
        return "realmID"
    }
    
}

extension HeroStatRealm {
    
    func toDomain() -> HeroStatDomain {
        return HeroStatDomain(realmID: self.realmID,
                              createdAt: self.createdAt,
                              updatedAt: self.updatedAt,
                              attackType: self.attackType,
                              baseAttackMax: self.baseAttackMax,
                              baseAttackMin: self.baseAttackMin,
                              baseArmor: self.baseArmor,
                              baseHealth: self.baseHealth,
                              baseMana: self.baseMana,
                              heroName: self.heroName,
                              image: self.image,
                              isFavorite: self.isFavorite,
                              moveSpeed: self.moveSpeed,
                              primaryAttribute: self.primaryAttribute,
                              roles: Array(self.roles))
    }
    
}

extension HeroStatDomain {
    
    func toRealm() -> HeroStatRealm {
        let object = HeroStatRealm()
        object.realmID = self.realmID
        object.createdAt = self.createdAt
        object.updatedAt = self.updatedAt
        object.attackType = self.attackType
        object.baseAttackMax = self.baseAttackMax
        object.baseAttackMin = self.baseAttackMin
        object.baseArmor = self.baseArmor
        object.baseHealth = self.baseHealth
        object.baseMana = self.baseMana
        object.heroName = self.heroName
        object.image = self.image
        object.isFavorite = self.isFavorite
        object.moveSpeed = self.moveSpeed
        object.primaryAttribute = self.primaryAttribute
        let _roles = List<String>()
        self.roles.forEach { _roles.append($0) }
        object.roles = _roles
        return object
    }
    
}
