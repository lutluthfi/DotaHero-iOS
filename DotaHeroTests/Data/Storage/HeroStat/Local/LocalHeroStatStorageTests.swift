//
//  LocalHeroStatStorageTests.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import XCTest
@testable import DEV_Dota_Hero

class LocalHeroStatStorageTests: XCTestCase {
    
    private lazy var sut = self.makeLocalHeroStatStorageSUT()
    private var insertedObject: HeroStatDomain!
    
    override func setUp() {
        super.setUp()
        self.makeStub()
    }
    
    override func tearDown() {
        self.removeStub()
        super.tearDown()
    }
    
    private func makeStub() {
        let object = HeroStatDomain.stubElement.toRealm()
        self.sut.realmStorage.realm.beginWrite()
        self.sut.realmStorage.realm.add(object)
        try! self.sut.realmStorage.realm.commitWrite()
        self.insertedObject = object.toDomain()
    }
    
    private func removeStub() {
        self.sut.realmStorage.realm.beginWrite()
        self.sut.realmStorage.realm.deleteAll()
        try! self.sut.realmStorage.realm.commitWrite()
    }
    
}

extension LocalHeroStatStorageTests {
    
    func test_fetchHeroStats_shouldFetchedInRealmStorage() throws {
        let result = try self.sut.localStorage
            .fetchHeroStats()
            .toBlocking()
            .single()
        
        XCTAssertTrue(!result.isEmpty)
        XCTAssertTrue(result.contains(insertedObject))
    }
    
    func test_insertHeroStats_shouldInsertedIntoRealmStorage() throws {
        let insertedObject = HeroStatDomain.stubElement
        
        let result = try self.sut.localStorage
            .insertHeroStats([insertedObject])
            .toBlocking()
            .single()
        
        XCTAssertTrue(!result.isEmpty)
        XCTAssertEqual(result, [self.insertedObject])
    }
    
}

struct LocalHeroStatStorageSUT {
    
    let localStorage: LocalHeroStatStorage
    let realmStorage: RealmStorageSharedMock
    
}

extension XCTest {
    
    func makeLocalHeroStatStorageSUT() -> LocalHeroStatStorageSUT {
        let realmStorage = self.makeRealmStorageMock()
        let localStorage = DefaultLocalHeroStatStorage(realmStorage: realmStorage)
        return LocalHeroStatStorageSUT(localStorage: localStorage, realmStorage: realmStorage)
    }
    
}
