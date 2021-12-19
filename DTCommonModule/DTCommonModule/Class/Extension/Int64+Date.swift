//
//  Int64.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 28/02/21.
//

import Foundation

public extension Int64 {
    
    func toDate(inMillis: Bool = false) -> Date {
        let _self = inMillis ? self / 1000 : self
        let timeInterval = TimeInterval(_self)
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    func toDateByGMT(inMillis: Bool = false) -> Date {
        let _self = inMillis ? self / 1000 : self
        let timezoneOffset =  TimeZone.current.secondsFromGMT()
        let timezoneEpochOffset = (Double(_self) + Double(timezoneOffset))
        return Date(timeIntervalSince1970: timezoneEpochOffset)
    }
    
}
