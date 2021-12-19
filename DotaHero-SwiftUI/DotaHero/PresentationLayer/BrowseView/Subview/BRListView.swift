//
//  BRListView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 15/11/21.
//

import DTDomainModule
import SwiftUI

struct BRListView: View {
    
    let heroesByRole: [String: [HeroDomain]]
    
    var body: some View {
        let heroes: [Dictionary<String, [HeroDomain]>.Element] = heroesByRole
            .sorted { $0.key < $1.key }
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 4) {
                ForEach(heroes, id: \.key) { (key, value) in
                    let role: String = key
                    let heroes: [HeroDomain] = value
                    BRListSectionView(title: role, heroes: heroes)
                }
            }
            Spacer()
        }
    }
    
}

struct BRListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let heroes: [HeroDomain] = HeroDomainStub.collection(count: 10)
        let role: String = "Carry"
        let heroesByRole = [role: heroes]
        BRListView(heroesByRole: heroesByRole)
    }
    
}
