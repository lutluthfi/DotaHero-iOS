//
//  DomainModuleAssembly.swift
//  DTDomainModule
//
//  Created by Arif Luthfiansyah on 15/11/21.
//

import Swinject

public final class DomainModuleAssembly: Assembly {
    public init() {
    }
    
    public func assemble(container: Container) {
        container.register(FetchAllHeroStatUseCase.self) { r in
            let heroStatRepository = r.resolve(HeroStatRepository.self)!
            return FetchAllHeroStatUseCaseImpl(repository: heroStatRepository)
        }
    }
}
