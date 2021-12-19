//
//  AppDIContainer.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 16/11/21.
//

import DTDataModule
import DTDomainModule
import Swinject

protocol AppDIContainerShared: AnyObject {
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service?
    
    func resolve<Service>(_ serviceType: Service.Type, name: String?) -> Service?
    
    func resolve<Service, T>(_ serviceType: Service.Type, argument: T) -> Service?
    
}

final class AppDIContainer {
    
    static let shared: AppDIContainerShared = AppDIContainer()
    
    let container = Container()
    let dataModuleAssembly = DataModuleAssembly()
    let domainModuleAssembly = DomainModuleAssembly()
    
    private init() {
        dataModuleAssembly.assemble(container: container)
        domainModuleAssembly.assemble(container: container)
    }
    
}

extension AppDIContainer: AppDIContainerShared {
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        resolve(serviceType, name: nil)
    }
    
    func resolve<Service>(_ serviceType: Service.Type, name: String?) -> Service? {
        container.resolve(serviceType, name: name)
    }
    
    func resolve<Service, T>(_ serviceType: Service.Type, argument: T) -> Service? {
        container.resolve(serviceType, argument: argument)
    }
    
}
