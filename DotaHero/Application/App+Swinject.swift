//
//  App+Swinject.swift
//  HealthHouse
//
//  Created by Arif Luthfiansyah on 21/08/21.
//

import DTDataModule
import DTDomainModule
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        let modules: [Assembly] = [DataModuleAssembly(), DomainModuleAssembly()]
        _ = Assembler(modules, container: defaultContainer)
    }
}
