//
//  BrowseFlowCoordinatorTests.swift
//  DotaHeroTests
//
//  Created by Arif Luthfiansyah on 08/04/21.
//

import XCTest
@testable import DEV_Dota_Hero

class BrowseFlowCoordinatorTests: XCTestCase {

    private lazy var sut = self.makeBrowseFlowCoordinatorSUT()
    
    override func tearDown() {
        self.removeStub()
        super.tearDown()
    }
    
    private func removeStub() {
        self.sut.navigationController.viewControllers.removeAll()
    }

}

extension BrowseFlowCoordinatorTests {
    
    func test_start_whenInstructorPushToListUI_thenTopViewControllerIsBSListController() {
        let requestValue = BSListViewModelRequest()
        let insturctor = BrowseFlowCoordinatorInstructor.pushToListUI(requestValue)
        
        self.sut.flowCoordinator.start(with: insturctor)
        
        XCTAssertTrue(self.sut.navigationController.topViewController is BSListController)
    }
    
    func test_start_whenInstructorPushToDetailUI_thenTopViewControllerIsBSDetailController() {
        let requestValue = BSDetailViewModelRequest(heroStat: .stubElement, similarHeroStats: [.stubElement])
        let insturctor = BrowseFlowCoordinatorInstructor.pushToDetailUI(requestValue)
        
        self.sut.flowCoordinator.start(with: insturctor)
        
        XCTAssertTrue(self.sut.navigationController.topViewController is BSDetailController)
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
