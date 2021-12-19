//
//  TableRowDomain.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 04/05/21.
//

import Foundation
import RxDataSources

public struct TableRowDomain {
    
    public static let attackType = TableRowDomain(placeholder: "Attack Type")
    public static let baseAttack = TableRowDomain(placeholder: "Base Attack")
    public static let baseArmor = TableRowDomain(placeholder: "Base Armor")
    public static let baseHealth = TableRowDomain(placeholder: "Base Health")
    public static let baseMana = TableRowDomain(placeholder: "Base Mana")
    public static let heroName = TableRowDomain(placeholder: "Hero Name")
    public static let heroImage = TableRowDomain(placeholder: "Hero Image")
    public static let moveSpeed = TableRowDomain(placeholder: "Move Speed")
    public static let primaryAttribute = TableRowDomain(placeholder: "Primary Attribute")
    public static let role = TableRowDomain(placeholder: "Role")
    
    public let placeholder: String
    
}

extension TableRowDomain: Equatable {
    
    public static func == (lhs: TableRowDomain, rhs: TableRowDomain) -> Bool {
        return lhs.placeholder == rhs.placeholder
    }
    
}

extension TableRowDomain: IdentifiableType {
    
    public typealias Identity = String
    
    public var identity: String {
        return self.placeholder
    }
    
}
