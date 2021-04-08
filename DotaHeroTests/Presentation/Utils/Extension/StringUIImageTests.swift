//
//  StringUIImageTests.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import XCTest
@testable import DEV_Dota_Hero

class StringUIImageTests: XCTestCase {

    func test_image_whenHasNoParams_thenSizeLessThan17() {
        let string = "🚀"
        
        let result = string.image()
        
        XCTAssertNotNil(result)
        XCTAssertLessThanOrEqual(result!.size.width, 17)
        XCTAssertLessThanOrEqual(result!.size.height, 17)
    }
    
    func test_image_whenSizeIs30_thenSizeEqual() {
        let string = "🚀"
        
        let result = string.image(size: CGSize(width: 30, height: 30))
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.size.width, 30)
        XCTAssertEqual(result!.size.height, 30)
    }

}
