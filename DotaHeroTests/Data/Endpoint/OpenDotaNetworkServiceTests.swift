//
//  OpenDotaNetworkServiceTests.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 06/04/21.
//

import RxBlocking
import RxSwift
import XCTest
@testable import DEV_Dota_Hero

class OpenDotaNetworkServiceTests: XCTestCase {

    private lazy var sut = self.makeOpenDotaNetworkServiceSUT()
    
    func test_fetchHeroStats_shouldFetchedAllHeroStatsFromOpenDotaEndpoint() throws {
        let request = FetchHeroStatDTO.Request()
        let result = try self.sut.networkService
            .fetchHeroStats(with: request, responseType: [FetchHeroStatDTO.Response].self)
            .toBlocking(timeout: self.sut.timeout)
            .single()
            
        XCTAssertTrue(!result.0.isEmpty)
        XCTAssertTrue(result.0.count > 100)
    }

}

struct OpenDotaNetworkServiceSUT {
    
    let networkService: OpenDotaNetworkService
    let timeout: TimeInterval
    
}

extension XCTest {
    
    func makeOpenDotaNetworkServiceSUT() -> OpenDotaNetworkServiceSUT {
        let session = self.makeSession()
        let networkService = OpenDotaNetworkService(session: session)
        return OpenDotaNetworkServiceSUT(networkService: networkService,
                                         timeout: session.sessionConfiguration.timeoutIntervalForRequest)
    }
    
}
