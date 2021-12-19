//
//  UIViewRoundTests.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import XCTest

class UIViewRoundTests: XCTestCase {

    func test_makeRound_whenHasNoParams_thenRoundedAllCorner() {
        let view = UIView()
        
        view.makeRound()
        
        XCTAssertTrue(view.clipsToBounds)
        XCTAssertNil(view.layer.borderColor)
        XCTAssertEqual(view.layer.borderWidth, 0)
        XCTAssertEqual(view.layer.cornerRadius, 8)
        XCTAssertEqual(view.layer.maskedCorners,
                       [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
    }
    
    func test_makeRound_whenHasParams_thenRoundedAllCorner() {
        let view = UIView()
        
        view.makeRound(borderColor: .blue, borderWidth: 16, cornerRad: 16, maskedCorner: [.layerMaxXMaxYCorner])
        
        XCTAssertTrue(view.clipsToBounds)
        XCTAssertEqual(view.layer.borderColor, UIColor.blue.cgColor)
        XCTAssertEqual(view.layer.borderWidth, 16)
        XCTAssertEqual(view.layer.cornerRadius, 16)
        XCTAssertEqual(view.layer.maskedCorners, [.layerMaxXMaxYCorner])
    }

}
