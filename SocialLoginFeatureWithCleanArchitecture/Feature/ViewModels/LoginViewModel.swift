//
//  LoginViewModel.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/22/24.
//

import Combine

final class LoginViewModel {
    private var socialLoginUsecase: SocialLoginUsecase!
    private var cancellables = Set<AnyCancellable>()

    @Published var selectedLoginButton: LoginButton?
    
    static func create(
        socialLoginUsecase: SocialLoginUsecase
    ) -> LoginViewModel {
        let viewModel = LoginViewModel()
        
        viewModel.socialLoginUsecase = socialLoginUsecase
        
        return viewModel
    }
    
    func createLoginButtons() -> [LoginButton] {
        return LoginButton.allCases
    }
    
    func handleLoginButtonTapped(for type: LoginButton) {
        selectedLoginButton = type
        
        let loginType: LoginType
        
        switch type {
        case .apple:
            loginType = .apple
        case .google:
            loginType = .google
        case .line:
            loginType = .line
        case .x:
            loginType = .x
        case .facebook:
            loginType = .facebook
        }
        
        socialLoginUsecase.login(loginType: loginType)
            .sink { completion in
                switch completion {
                case .finished:
                    print("After end login logic")
                case .failure(let error):
                    break
                }
            } receiveValue: {
                print("After value changed \($0)")
            }
            .store(in: &cancellables)
    }
}
