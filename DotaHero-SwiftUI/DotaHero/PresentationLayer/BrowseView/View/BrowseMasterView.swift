  //
  //  BrowseMasterView.swift
  //  DotaHero
  //
  //  Created by Arif Luthfiansyah on 13/11/21.
  //

import Combine
import DTDomainModule
import Kingfisher
import RxSwift
import SwiftUI

struct BrowseMasterView: View {
  // DI Variable
  @ObservedObject
  var viewModel: BrowseViewModel
  
  // Variable
  let disposeBag = DisposeBag()
  
  var body: some View {
    NavigationView {
      VStack {
        BRListView(heroesByRole: viewModel.heroByRolePublished)
      }
      .navigationTitle("Dota 2")
      
    }
    .onAppear {
      viewModel.loadHeroesByRole()
    }
  }
}

struct BrowseMasterView_Previews: PreviewProvider {
  static var previews: some View {
    BRScrollCardView()
  }
}

struct BRScrollCardView: View {
  
  var body: some View {
    BrowseViewBuilder().build()
  }
}

struct BRCardView: View {
  
  var imageURL: URL? {
    URL(string: "https://api.opendota.com/apps/dota2/images/dota_react/heroes/antimage.png?")
  }
  
  var body: some View {
    GeometryReader { (geometry) in
      VStack(alignment: .center, spacing: 8) {
        KFImage(imageURL)
          .cacheMemoryOnly()
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(height: geometry.size.height, alignment: .center)
          .background(Color.gray)
          .clipped()
      }
      .cornerRadius(16)
      .frame(height: geometry.size.height)
      .shadow(radius: 10)
    }
  }
}
