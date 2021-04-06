//
//  FetchAllHeroStatUseCaseTests.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 07/04/21.
//

import RxBlocking
import RxSwift
import RxTest
import XCTest
@testable import DEV_Dota_Hero

class FetchAllHeroStatUseCaseTests: XCTestCase {

    private lazy var sut = self.makeFetchAllHeroStatUseCaseSUT()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        self.removeStub()
        super.tearDown()
    }
    
    private func insertHeroStasIntoLocalMakeStub(_ observable: ([HeroStatDomain], NetworkProgress?)) -> Observable<([HeroStatDomain], NetworkProgress?)> {
        return self.sut.repository
            .insertHeroStats(observable.0, into: .realm)
            .flatMap { _ -> Observable<([HeroStatDomain], NetworkProgress?)> in
                return .just(observable)
            }
    }
    
    private func makeRemoteStub(testExpectation: XCTestExpectation) {
        self.sut.repository
            .fetchHeroStats(in: .remote)
            .flatMap(insertHeroStasIntoLocalMakeStub(_:))
            .subscribe(onNext: { [unowned testExpectation] _ in
                testExpectation.fulfill()
            })
            .disposed(by: self.sut.disposeBag)
    }
    
    private func removeStub() {
        self.sut.realmStorage.realm.beginWrite()
        self.sut.realmStorage.realm.deleteAll()
        try! self.sut.realmStorage.realm.commitWrite()
    }
    
}

extension FetchAllHeroStatUseCaseTests {
    
    func test_execute_whenEmptyInLocal_thenFetchedAllHeroStatInRemote() throws {
        let request = FetchAllHeroStatUseCaseRequest()
        let result = try self.sut.useCase
            .execute(request)
            .toBlocking(timeout: self.sut.timeout)
            .single()
        
        XCTAssertTrue(result.heroStats.count > 100)
        XCTAssertNotNil(result.progress)
    }
    
    func test_execute_whenNotEmptyInLocal_thenFetchedAllHeroStatInLocal() throws {
        let testExpectation = self.expectation(description: "")
        self.makeRemoteStub(testExpectation: testExpectation)
        self.wait(for: [testExpectation], timeout: self.sut.timeout)
        
        let request = FetchAllHeroStatUseCaseRequest()
        let result = try self.sut.useCase
            .execute(request)
            .toBlocking(timeout: self.sut.timeout)
            .single()
        
        XCTAssertTrue(result.heroStats.count > 100)
        XCTAssertNil(result.progress)
    }
    
}

struct FetchAllHeroStatUseCaseSUT {
    
    let disposeBag: DisposeBag
    let realmStorage: RealmStorageSharedMock
    let repository: HeroStatRepository
    let semaphore: DispatchSemaphore
    let timeout: TimeInterval
    let useCase: FetchAllHeroStatUseCase
    
}

extension XCTest {
    
    func makeFetchAllHeroStatUseCaseSUT() -> FetchAllHeroStatUseCaseSUT {
        let repositorySUT = self.makeHeroStatRepositorySUT()
        let useCase = DefaultFetchAllHeroStatUseCase(repository: repositorySUT.repository)
        return FetchAllHeroStatUseCaseSUT(disposeBag: repositorySUT.disposeBag,
                                          realmStorage: repositorySUT.realmStorage,
                                          repository: repositorySUT.repository,
                                          semaphore: repositorySUT.semaphore,
                                          timeout: repositorySUT.timeout,
                                          useCase: useCase)
    }
    
}
