//
//  RemoteHeroStatStorageTests.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import XCTest
@testable import DEV_Dota_Hero

class RemoteHeroStatStorageTests: XCTestCase {

    private lazy var sut = self.makeRemoteHeroStatStorageSUT()
    
    func test_fetchHeroStats_shouldFetchedAllHeroStatsInOpenDotaEndpoint() throws {
        let result = try self.sut.remoteStorage
            .fetchHeroStats()
            .toBlocking(timeout: self.sut.timeout)
            .single()
        
        XCTAssertTrue(!result.0.isEmpty)
        XCTAssertTrue(result.0.count > 100)
        XCTAssertTrue(result.0.contains(.stubElement))
    }

}

struct RemoteHeroStatStorageSUT {
    
    let remoteStorage: RemoteHeroStatStorage
    let timeout: TimeInterval
    
}

extension XCTest {
    
    func makeRemoteHeroStatStorageSUT() -> RemoteHeroStatStorageSUT {
        let networkServiceSUT = self.makeOpenDotaNetworkServiceSUT()
        let remoteStorage = DefaultRemoteHeroStatStorage(openDotaNetworkService: networkServiceSUT.networkService)
        return RemoteHeroStatStorageSUT(remoteStorage: remoteStorage, timeout: networkServiceSUT.timeout)
    }
    
}