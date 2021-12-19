//
//  BrowseViewBuilder.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 16/11/21.
//

import DTDomainModule
import SwiftUI

final class BrowseViewBuilder {
  private let view: BrowseMasterView
  private  let viewModel: BrowseViewModel
  
  init() {
    let di: AppDIContainerShared = AppDIContainer.shared
    let fetchAllHeroStatUseCase = di.resolve(FetchAllHeroStatUseCase.self)!
    viewModel = BrowseViewModel(
      fetchAllHeroStatUseCase: fetchAllHeroStatUseCase
    )
    view = BrowseMasterView(viewModel: viewModel)
  }
  
  func build() -> BrowseMasterView {
    view
  }
}
