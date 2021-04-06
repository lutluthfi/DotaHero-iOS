//
//  AppDIContainer.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/04/21.
//

import Alamofire
import RxAlamofire
import UIKit

public typealias PresentationFactory = FlowCoordinatorFactory&ControllerFactory
public typealias ControllerFactory = BrowseFlowCoordinatorFactory
public typealias NetworkProgress = RxProgress

public final class AppDIContainer {
    
    let navigationController: UINavigationController
    
    lazy var session: Session = {
        let session = Session(configuration: self.sessionConfiguration, eventMonitors: [NetworkLogger()])
        return session
    }()
    lazy var sessionConfiguration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        return configuration
    }()
    lazy var openDotaAPIService: OpenDotaNetworkService = {
        let service = OpenDotaNetworkService(session: self.session)
        return service
    }()
    
    // MARK: Storage
    lazy var localHeroStatStorage: LocalHeroStatStorage = DefaultLocalHeroStatStorage()
    lazy var remoteHeroStatStorage: RemoteHeroStatStorage = DefaultRemoteHeroStatStorage(openDotaNetworkService: self.openDotaAPIService)
    
    // MARK: Init Function
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
