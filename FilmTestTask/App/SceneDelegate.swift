//
//  SceneDelegate.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        let assmblyBuilder = ModuleBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assmblyBuilder)
        router.initialViewController()
//        router.showMovie(id: "")
//        router.showSearchMovies()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}

