//
//  SceneDelegate.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/21/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.rootViewController = LoginViewController()
        self.window?.makeKeyAndVisible()
    }
}
