//
//  SectionItemDomain.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import RxDataSources

public struct SectionItemDomain<Item> {
    
    public let footer: String?
    public let header: String?
    public var items: [Item]
    
}

extension SectionItemDomain: SectionModelType {
    
    public init(original: SectionItemDomain, items: [Item]) {
        self = original
        self.items = items
    }
    
}
