//
//  BRListSectionView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 16/11/21.
//

import DTDomainModule
import SwiftUI

struct BRListSectionView: View {
    
    let title: String
    let heroes: [HeroDomain]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.headline)
                .padding(10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 4, content: {
                    ForEach(heroes, id: \.realmID) { hero in
                        BRElementView(imagePath: hero.image)
                    }
                })
            }
        }
    }
    
}

struct BRHeaderSectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        let title = "Carry"
        let heroes: [HeroDomain] = HeroDomainStub.collection(count: 10)
        BRListSectionView(title: title, heroes: heroes)
    }
    
}
