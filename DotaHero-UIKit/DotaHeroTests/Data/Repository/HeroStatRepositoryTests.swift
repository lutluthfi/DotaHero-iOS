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
    
    private lazy var sut = makeHeroStatRepositorySUT()
    
    override func setUp() {
        super.setUp()
        makeStub()
    }
    
    override func tearDown() {
        removeStub()
        super.tearDown()
    }
    
    private func makeStub() {
        let insertedObject = HeroDomain.stubElement
        sut.localStorage
            .insertHeroStats([insertedObject])
            .subscribe(onNext: { [unowned self] _ in
                sut.semaphore.signal()
            })
            .disposed(by: sut.disposeBag)
        sut.semaphore.wait()
    }
    
    private func removeStub() {
        sut.realmStorage.realm.beginWrite()
        sut.realmStorage.realm.deleteAll()
        try! sut.realmStorage.realm.commitWrite()
    }
    
}

extension HeroStatRepositoryTests {
    
    func test_fetchHeroStats_whenStoragePointRealm_thenFetchedAllHeroStatsInRealm() throws {
        let storagePoint = StoragePoint.realm
        
        let result = try sut.repository
            .fetchHeroStats(in: storagePoint)
            .toBlocking()
            .single()
        
        XCTAssertTrue(!result.0.isEmpty)
        XCTAssertTrue(result.0.contains(.stubElement))
    }
    
    func test_fetchHeroStats_whenStoragePointRemote_thenFetchedAllHeroStatsInRemote() throws {
        let storagePoint = StoragePoint.remote
        
        let result = try sut.repository
            .fetchHeroStats(in: storagePoint)
            .toBlocking()
            .single()
        
        XCTAssertTrue(!result.0.isEmpty)
        XCTAssertTrue(result.0.count > 100)
        XCTAssertTrue(result.0.contains(.stubElement))
    }
    
    func test_insertHeroStats_whenStoragePointRealm_thenInsertedIntoRealmStorage() throws {
        let storagePoint = StoragePoint.realm
        let insertedObject = HeroDomain.stubElement
        
        let result = try sut.repository
            .insertHeroStats([insertedObject], into: storagePoint)
            .toBlocking()
            .single()
        
        XCTAssertTrue(!result.isEmpty)
        XCTAssertEqual(result, [insertedObject])
    }
    
    func test_insertHeroStats_whenStoragePointRemote_thenInsertedIntoRealmStorage() {
        let storagePoint = StoragePoint.remote
        let insertedObject = HeroDomain.stubElement
        
        XCTAssertThrowsError(try sut.repository
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
        let realmStorage = makeRealmStorageMock()
        let networkServiceSUT = makeOpenDotaNetworkServiceSUT()
        let localStorage = DefaultLocalHeroStatStorage(realmStorage: makeRealmStorageMock())
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
