//
//  RealmStorage.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 10/01/20.
//  Copyright © 2020. All rights reserved.
//

import RealmSwift

public protocol RealmStorageShared {
    
    var realm: Realm { get }
    var schemaVersion: UInt64 { get }
    
}

public final class RealmStorage {
    
    public static let shared: RealmStorageShared = RealmStorage()
    
    let _realm: Realm!
    
    private init() {
        self._realm = try! Realm(queue: .main)
    }
    
}

extension RealmStorage: RealmStorageShared {
    
    public var realm: Realm {
        return self._realm
    }
    
    public var schemaVersion: UInt64 {
        return UInt64(1)
    }
    
}
