//
//  BRElementView.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 15/11/21.
//

import DTDomainModule
import Kingfisher
import SwiftUI

struct BRElementView: View {
  
  let imagePath: String
  
  var imageURL: URL {
    URL(string: imagePath)!
  }
  
  var body: some View {
    VStack(alignment: .center, spacing: 8) {
      KFImage(imageURL)
        .cacheMemoryOnly()
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(
          width: 178,
          height: 100,
          alignment: .center
        )
        .background(Color.gray)
        .clipped()
    }
    .onTapGesture {
      
    }
  }
  
}

struct BRElementView_Previews: PreviewProvider {
  
  static var previews: some View {
    let hero: HeroDomain = HeroDomainStub.single
    let imagePath: String = hero.image
    BRElementView(imagePath: imagePath)
  }
  
}
