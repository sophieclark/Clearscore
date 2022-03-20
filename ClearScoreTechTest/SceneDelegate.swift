//
//  SceneDelegate.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 18/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        coordinator = AppCoordinator(navigationController: navigationController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        #if TESTS
        self.window = window
        
        if CommandLine.arguments.contains("-launchWithSuccess") || CommandLine.arguments.contains("-launchWithFailure") {
            coordinator?.start()
        }
        return
        #else
        coordinator?.start()
        self.window = window
        #endif
        
    }
}

