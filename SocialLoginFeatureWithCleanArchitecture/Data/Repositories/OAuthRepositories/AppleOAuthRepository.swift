//
//  AppleAuthRepository.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/22/24.
//

import Combine
import AuthenticationServices

final class AppleOAuthRepository: NSObject {
    private var loginCompletion: (() -> Void)?
    private var errorCompletion: (() -> Void)?
}

extension AppleOAuthRepository: SocialLoginOAtuhRepository {
    func login() -> AnyPublisher<Void, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            self.loginCompletion = {
                promise(.success(()))
            }
            
            self.errorCompletion = {
                promise(.failure(NSError(domain: "AppleLoginError", code: 0)))
            }
            
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        }
        .eraseToAnyPublisher()
    }
    
    func logout() {
        
    }
}

extension AppleOAuthRepository: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let authorizationCode = appleIDCredential.authorizationCode,
                  let identityTokne = appleIDCredential.identityToken else { return }
            
            let fullName = appleIDCredential.fullName?.formatted() ?? ""
            let email = appleIDCredential.email ?? ""
            
            let token = String(data: identityTokne, encoding: .utf8)!
            let code = String(data: authorizationCode, encoding: .utf8)!
            
            // TODO: Server 연결
            loginCompletion?()
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        errorCompletion?()
    }
}
