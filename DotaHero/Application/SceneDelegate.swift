//
//  SceneDelegate.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/04/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    lazy var navigationController: UINavigationController = {
        let controller = UINavigationController()
        controller.view.backgroundColor = .white
        return controller
    }()
    lazy var appDIContainer = AppDIContainer(navigationController: self.navigationController)
    lazy var appFlowCoordinator: AppFlowCoordinator = {
        return DefaultAppFlowCoordinator(navigationController: self.navigationController,
                                         factory: self.appDIContainer)
    }()
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
        self.appFlowCoordinator.start(with: .default)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

