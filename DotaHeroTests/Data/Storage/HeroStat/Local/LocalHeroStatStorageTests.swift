//
//  LocalHeroStatStorageTests.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import XCTest
@testable import DEV_Dota_Hero

class LocalHeroStatStorageTests: XCTestCase {
    
    private lazy var sut = makeLocalHeroStatStorageSUT()
    private var insertedObject: HeroDomain!
    
    override func setUp() {
        super.setUp()
        makeStub()
    }
    
    override func tearDown() {
        removeStub()
        super.tearDown()
    }
    
    private func makeStub() {
        let object = HeroDomain.stubElement.toRealm()
        sut.realmStorage.realm.beginWrite()
        sut.realmStorage.realm.add(object)
        try! sut.realmStorage.realm.commitWrite()
        insertedObject = object.toDomain()
    }
    
    private func removeStub() {
        sut.realmStorage.realm.beginWrite()
        sut.realmStorage.realm.deleteAll()
        try! sut.realmStorage.realm.commitWrite()
    }
    
}

extension LocalHeroStatStorageTests {
    
    func test_fetchHeroStats_shouldFetchedInRealmStorage() throws {
        let result = try sut.localStorage
            .fetchHeroStats()
            .toBlocking()
            .single()
        
        XCTAssertTrue(!result.isEmpty)
        XCTAssertTrue(result.contains(insertedObject))
    }
    
    func test_insertHeroStats_shouldInsertedIntoRealmStorage() throws {
        let insertedObject = HeroDomain.stubElement
        
        let result = try sut.localStorage
            .insertHeroStats([insertedObject])
            .toBlocking()
            .single()
        
        XCTAssertTrue(!result.isEmpty)
        XCTAssertEqual(result, [insertedObject])
    }
    
}

struct LocalHeroStatStorageSUT {
    
    let localStorage: LocalHeroStatStorage
    let realmStorage: RealmStorageSharedMock
    
}

extension XCTest {
    
    func makeLocalHeroStatStorageSUT() -> LocalHeroStatStorageSUT {
        let realmStorage = makeRealmStorageMock()
        let localStorage = DefaultLocalHeroStatStorage(realmStorage: realmStorage)
        return LocalHeroStatStorageSUT(localStorage: localStorage, realmStorage: realmStorage)
    }
    
}
