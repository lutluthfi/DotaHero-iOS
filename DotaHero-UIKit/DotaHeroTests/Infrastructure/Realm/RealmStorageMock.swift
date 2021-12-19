//
//  RealmStorageMock.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import Foundation
import RealmSwift
@testable import DEV_Dota_Hero

class RealmStorageMock {
    
    public static let shared: RealmStorageSharedMock = RealmStorageMock()
    
    let _realm: Realm!
    
    private init() {
        let configuration = Realm.Configuration(inMemoryIdentifier: "RealmStorageMock")
        _realm = try! Realm(configuration: configuration, queue: .main)
    }
}

protocol RealmStorageSharedMock: RealmStorageShared {
    
}

extension RealmStorageMock: RealmStorageSharedMock {
    
    var realm: Realm {
        return _realm
    }
    var schemaVersion: UInt64 {
        return UInt64(1)
    }
    
}
