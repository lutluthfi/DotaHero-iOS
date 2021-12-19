//
//  SceneDelegate.swift
//  DotaHero
//
//  Created by Arif Luthfiansyah on 05/04/21.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    lazy var navigationController: UINavigationController = {
        let controller = UINavigationController()
        controller.view.backgroundColor = .white
        return controller
    }()
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let request = HeroListViewModelRequest()
        let controller = HeroListUIBuilder(navigationController, request: request).build()
        navigationController.pushViewController(controller, animated: true)
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

