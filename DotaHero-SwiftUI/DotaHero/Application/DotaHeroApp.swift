//
//  DotaHeroApp.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 13/11/21.
//

import DTDomainModule
import SwiftUI

@main
struct DotaHeroApp: App {
    
    var body: some Scene {
        WindowGroup {
            BrowseViewBuilder().build()
        }
    }
    
}
