//
//  HeroStatRepositoryTests.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import RxBlocking
import RxSwift
import RxTest
import XCTest
@testable import DEV_Dota_Hero

class HeroStatRepositoryTests: XCTestCase {
    
    private lazy var sut = self.makeHeroStatRepositorySUT()
    
    override func setUp() {
        super.setUp()
        self.makeStub()
    }
    
    override func tearDown() {
        self.removeStub()
        super.tearDown()
    }
    
    private func makeStub() {
        let insertedObject = HeroStatDomain.stubElement
        self.sut.localStorage
            .insertHeroStats([insertedObject])
            .subscribe(onNext: { [unowned self] _ in
                self.sut.semaphore.signal()
            })
            .disposed(by: self.sut.disposeBag)
        self.sut.semaphore.wait()
    }
    
    private func removeStub() {
        self.sut.realmStorage.realm.beginWrite()
        self.sut.realmStorage.realm.deleteAll()
        try! self.sut.realmStorage.realm.commitWrite()
    }
    
}

extension HeroStatRepositoryTests {
    
    func test_fetchHeroStats_whenStoragePointRealm_thenFetchedAllHeroStatsInRealm() throws {
        let storagePoint = StoragePoint.realm
        
        let result = try self.sut.repository
            .fetchHeroStats(in: storagePoint)
            .toBlocking()
            .single()
        
        XCTAssertTrue(!result.0.isEmpty)
        XCTAssertTrue(result.0.contains(.stubElement))
    }
    
    func test_fetchHeroStats_whenStoragePointRemote_thenFetchedAllHeroStatsInRemote() throws {
        let storagePoint = StoragePoint.remote
        
        let result = try self.sut.repository
            .fetchHeroStats(in: storagePoint)
            .toBlocking()
            .single()
        
        XCTAssertTrue(!result.0.isEmpty)
        XCTAssertTrue(result.0.count > 100)
        XCTAssertTrue(result.0.contains(.stubElement))
    }
    
    func test_insertHeroStats_whenStoragePointRealm_thenInsertedIntoRealmStorage() throws {
        let storagePoint = StoragePoint.realm
        let insertedObject = HeroStatDomain.stubElement
        
        let result = try self.sut.repository
            .insertHeroStats([insertedObject], into: storagePoint)
            .toBlocking()
            .single()
        
        XCTAssertTrue(!result.isEmpty)
        XCTAssertEqual(result, [insertedObject])
    }
    
    func test_insertHeroStats_whenStoragePointRemote_thenInsertedIntoRealmStorage() {
        let storagePoint = StoragePoint.remote
        let insertedObject = HeroStatDomain.stubElement
        
        XCTAssertThrowsError(try self.sut.repository
                                .insertHeroStats([insertedObject], into: storagePoint)
                                .toBlocking()
                                .single()) { (error) in
            XCTAssertTrue(error is PlainError)
            XCTAssertEqual(error.localizedDescription, "HeroStatRepository -> insertHeroStats() is not available for Remote")
        }
    }
    
}

struct HeroStatRepositorySUT {
    
    let disposeBag: DisposeBag
    let localStorage: LocalHeroStatStorage
    let realmStorage: RealmStorageSharedMock
    let remoteStorage: RemoteHeroStatStorage
    let repository: HeroStatRepository
    let semaphore: DispatchSemaphore
    let timeout: TimeInterval
    
}

extension XCTest {
    
    func makeHeroStatRepositorySUT() -> HeroStatRepositorySUT {
        let disposeBag = DisposeBag()
        let semaphore = DispatchSemaphore(value: 0)
        let realmStorage = self.makeRealmStorageMock()
        let networkServiceSUT = self.makeOpenDotaNetworkServiceSUT()
        let localStorage = DefaultLocalHeroStatStorage(realmStorage: self.makeRealmStorageMock())
        let remoteStorage = DefaultRemoteHeroStatStorage(openDotaNetworkService: networkServiceSUT.networkService)
        let repository = DefaultHeroStatRepository(localStorage: localStorage, remoteStorage: remoteStorage)
        return HeroStatRepositorySUT(disposeBag: disposeBag,
                                      localStorage: localStorage,
                                      realmStorage: realmStorage,
                                      remoteStorage: remoteStorage,
                                      repository: repository,
                                      semaphore: semaphore,
                                      timeout: networkServiceSUT.timeout)
    }
    
}
