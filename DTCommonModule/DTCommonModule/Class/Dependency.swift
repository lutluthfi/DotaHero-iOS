//
//  Dependency.swift
//  HealthHouse
//
//  Created by Arif Luthfiansyah on 21/08/21.
//

import Swinject
import SwinjectStoryboard

public final class Dependency {
    public static func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return resolve(serviceType, name: nil)
    }
    
    public static func resolve<Service>(_ serviceType: Service.Type, name: String?) -> Service? {
        let threadSafeContainer: Resolver = SwinjectStoryboard.defaultContainer.synchronize()
        return threadSafeContainer.resolve(serviceType, name: name)
    }
    
    public static func resolve<Service, T>(_ serviceType: Service.Type, argument: T) -> Service? {
        let threadSafeContainer: Resolver = SwinjectStoryboard.defaultContainer.synchronize()
        return threadSafeContainer.resolve(serviceType, argument: argument)
    }
}
