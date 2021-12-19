//
//  BrowseFlowCoordinatorTests.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import XCTest
@testable import DEV_Dota_Hero

class BrowseFlowCoordinatorTests: XCTestCase {

    private lazy var sut = makeBrowseFlowCoordinatorSUT()
    
    override func tearDown() {
        removeStub()
        super.tearDown()
    }
    
    private func removeStub() {
        sut.navigationController.viewControllers.removeAll()
    }

}

extension BrowseFlowCoordinatorTests {
    
    func test_start_whenInstructorPushToListUI_thenTopViewControllerIsHeroListController() {
        let request = HeroListViewModelRequest()
        let insturctor = BrowseFlowCoordinatorInstructor.pushToListUI(request)
        
        sut.flowCoordinator.start(with: insturctor)
        
        XCTAssertTrue(sut.navigationController.topViewController is HeroListController)
    }
    
    func test_start_whenInstructorPushToDetailUI_thenTopViewControllerIsBSDetailController() {
        let request = BSDetailViewModelRequest(heroStat: .stubElement, similarHeroStats: [.stubElement])
        let insturctor = BrowseFlowCoordinatorInstructor.pushToDetailUI(request)
        
        sut.flowCoordinator.start(with: insturctor)
        
        XCTAssertTrue(sut.navigationController.topViewController is BSDetailController)
    }
    
}

struct BrowseFlowCoordinatorSUT {
    
    let flowCoordinator: BrowseFlowCoordinator
    let navigationController: UINavigationController
    
}

extension XCTest {
    
    func makeBrowseFlowCoordinatorSUT() -> BrowseFlowCoordinatorSUT {
        let navigationController = UINavigationController()
        let diContainer = AppDIContainer(navigationController: navigationController)
        let flowCoordinator: BrowseFlowCoordinator = DefaultBrowseFlowCoordinator(navigationController: navigationController,
                                                                                  factory: diContainer)
        return BrowseFlowCoordinatorSUT(flowCoordinator: flowCoordinator, navigationController: navigationController)
    }
    
}
