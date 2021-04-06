//
//  Int64DateTests.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 31/03/21.
//

import XCTest
@testable import DEV_Dota_Hero

class Int64DateTests: XCTestCase {
    
    private let timestamp = Int64(978282061)
    private let timestampMillisecond = Int64(978282061000)
    private let date: Date = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.date(from: "01-01-2001 01:01:01 AM")!
    }()
    
    func test_toDate_whenNotInMillis_shouldEqual() {
        XCTAssertEqual(self.timestamp.toDate(), self.date)
    }
    
    func test_toDate_whenInMillis_shouldEqual() {
        XCTAssertEqual(self.timestampMillisecond.toDate(inMillis: true), self.date)
    }

}
