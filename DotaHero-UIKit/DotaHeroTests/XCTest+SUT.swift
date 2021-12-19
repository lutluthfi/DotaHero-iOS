//
//  XCTest+SUT.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import Alamofire
import XCTest
@testable import DEV_Dota_Hero

extension XCTest {
    
    func makeRealmStorageMock() -> RealmStorageSharedMock {
        return RealmStorageMock.shared
    }
    func makeSession() -> Session {
        let session = Session(configuration: makeSessionConfiguration(),
                              eventMonitors: [NetworkLogger()])
        return session
    }
    func makeSessionConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        return configuration
    }
    
}
