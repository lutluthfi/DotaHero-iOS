//
//  SectionDomain.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import RxDataSources

public struct SectionDomain<Item: Equatable&IdentifiableType> {
    
    public var header: String
    public var footer: String
    public var items: [Item]
    
}

extension SectionDomain: SectionModelType, AnimatableSectionModelType {
    
    public var identity: String {
        return self.header
    }
    
    public init(original: SectionDomain, items: [Item]) {
        self = original
        self.items = items
    }
    
}
