//
//  FetchHeroStatDTO.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import Alamofire
import Foundation

// MARK: FetchHeroStatDTO
public struct FetchHeroStatDTO {
    
    public struct Request: Encodable {
        
        public var method: HTTPMethod {
            return .get
        }
        public var path: String {
            return "herostats"
        }
        
    }
    
    public struct Response: Decodable {
        
        public let agiGain: Double? //
        public let attackRange: Int?
        public let attackRate: Double? //
        public let attackType: String?
        public let baseAgi: Int?
        public let baseArmor: Double?
        public let baseAttackMax: Int?
        public let baseAttackMin: Int?
        public let baseHealth: Int?
        public let baseHealthRegen: Double? //
        public let baseInt: Int?
        public let baseMana: Int?
        public let baseManaRegen: Double? //
        public let baseMr: Int?
        public let baseStr: Int?
        public let cmEnabled: Bool?
        public let id: Int?
        public let img: String?
        public let intGain: Double? //
        public let heroID: Int?
        public let icon: String?
        public let legs: Int?
        public let localizedName: String?
        public let moveSpeed: Int?
        public let name: String?
        public let nullPick: Int?
        public let nullWin: Int?
        public let primaryAttr: String?
        public let proBan: Int?
        public let projectileSpeed: Int?
        public let proPick: Int?
        public let proWin: Int?
        public let roles: [String]?
        public let strGain: Double? //
        public let the1Pick: Int?
        public let the1Win: Int?
        public let the2Pick: Int?
        public let the2Win: Int?
        public let the3Pick: Int?
        public let the3Win: Int?
        public let the4Pick: Int?
        public let the4Win: Int?
        public let the5Pick: Int?
        public let the5Win: Int?
        public let the6Pick: Int?
        public let the6Win: Int?
        public let the7Pick: Int?
        public let the7Win: Int?
        public let the8Pick: Int?
        public let the8Win: Int?
        public let turboPicks: Int?
        public let turboWINS: Int?
        public let turnRate: Double? //
        
        enum CodingKeys: String, CodingKey {
            case agiGain = "agi_gain"
            case attackRate = "attack_rate"
            case attackRange = "attack_range"
            case attackType = "attack_type"
            case baseAgi = "base_agi"
            case baseArmor = "base_armor"
            case baseAttackMax = "base_attack_max"
            case baseAttackMin = "base_attack_min"
            case baseHealth = "base_health"
            case baseHealthRegen = "base_health_regen"
            case baseInt = "base_int"
            case baseMana = "base_mana"
            case baseManaRegen = "base_mana_regen"
            case baseMr = "base_mr"
            case baseStr = "base_str"
            case cmEnabled = "cm_enabled"
            case icon
            case id
            case img
            case intGain = "int_gain"
            case heroID = "hero_id"
            case legs
            case localizedName = "localized_name"
            case moveSpeed = "move_speed"
            case name
            case nullPick = "null_pick"
            case nullWin = "null_win"
            case primaryAttr = "primary_attr"
            case proBan = "pro_ban"
            case proWin = "pro_win"
            case projectileSpeed = "projectile_speed"
            case proPick = "pro_pick"
            case roles
            case strGain = "str_gain"
            case turnRate = "turn_rate"
            case the1Pick = "1_pick"
            case the1Win = "1_win"
            case the2Pick = "2_pick"
            case the2Win = "2_win"
            case the3Pick = "3_pick"
            case the3Win = "3_win"
            case the4Pick = "4_pick"
            case the4Win = "4_win"
            case the5Pick = "5_pick"
            case the5Win = "5_win"
            case the6Pick = "6_pick"
            case the6Win = "6_win"
            case the7Pick = "7_pick"
            case the7Win = "7_win"
            case the8Pick = "8_pick"
            case the8Win = "8_win"
            case turboPicks = "turbo_picks"
            case turboWINS = "turbo_wins"
        }
        
    }
    
}

extension FetchHeroStatDTO.Response {
    
    func toDomain() -> HeroStatDomain {
        let now = Date().toInt64()
        return HeroStatDomain(realmID: self.id == nil ? "" : String(self.id!),
                              createdAt: now,
                              updatedAt: now,
                              attackType: self.attackType ?? "",
                              baseAttackMax: self.baseAttackMax ?? 0,
                              baseAttackMin: self.baseAttackMin ?? 0,
                              baseArmor: self.baseArmor ?? 0,
                              baseHealth: self.baseHealth ?? 0,
                              baseMana: self.baseMana ?? 0,
                              heroName: self.localizedName ?? "",
                              moveSpeed: self.moveSpeed ?? 0,
                              primaryAttribute: self.primaryAttr ?? "",
                              roles: self.roles ?? [])
    }
    
}
