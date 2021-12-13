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
    let _schemaVersion = UInt64(2)
    
    private init() {
        var configuration = Realm.Configuration()
        configuration.schemaVersion = self._schemaVersion
        configuration.migrationBlock = { (migration, oldSchemaVersion) in }
        Realm.Configuration.defaultConfiguration = configuration
        let realm = try! Realm(queue: .main)
        self._realm = realm
    }
    
}

extension RealmStorage: RealmStorageShared {
    
    public var realm: Realm {
        return self._realm
    }
    
    public var schemaVersion: UInt64 {
        return self._schemaVersion
    }
    
}
