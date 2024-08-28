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
                
        storeRepositories()
        
        let container = DIContainer.shared
        
        let usecase = SocialLoginUseCase.create(
            appleOAuthRepo: container.resolve(AppleOAuthRepository.self)!,
            googleOAuthRepo: container.resolve(GoogleOAuthRepository.self)!,
            lineOAuthRepo: container.resolve(LineOAuthRepository.self)!,
            twitterOAuthRepo: container.resolve(TwitterOAuthRepository.self)!,
            facebookOAuthRepo: container.resolve(FacebookOAuthRepository.self)!,
            userRepository: container.resolve(UserInfoRepository.self)!
        )
        
        let viewModel = LoginViewModel.create(socialLoginUsecase: usecase)
        let viewController = LoginViewController.create(viewModel: viewModel)
        
        self.window = window
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
    
    private func storeRepositories() {
        DIContainer.shared.register(
            AppleOAuthRepository.self,
            dependency: AppleOAuthRepository()
        )
        
        DIContainer.shared.register(GoogleOAuthRepository.self, dependency: GoogleOAuthRepository())
        DIContainer.shared.register(LineOAuthRepository.self, dependency: LineOAuthRepository())
        DIContainer.shared.register(TwitterOAuthRepository.self, dependency: TwitterOAuthRepository())
        DIContainer.shared.register(FacebookOAuthRepository.self, dependency: FacebookOAuthRepository())
        DIContainer.shared.register(UserInfoRepository.self, dependency: UserInfoRepository())
    }
}
