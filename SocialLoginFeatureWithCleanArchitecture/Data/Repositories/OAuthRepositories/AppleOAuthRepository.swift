//
//  AppleAuthRepository.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/22/24.
//

import Combine
import AuthenticationServices

final class AppleOAuthRepository: NSObject {
    private let queue: DispatchQueue!
    
    private var loginCompletion: ((UserInfo) -> Void)?
    private var errorCompletion: (() -> Void)?
    
    init(
        queue: DispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.queue = queue
    }
}

extension AppleOAuthRepository: SocialLoginOAtuhRepositoryInterface {
    func login() -> AnyPublisher<UserInfo, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            self.queue.async {
                
                self.loginCompletion = {
                    promise(.success(($0)))
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
        }
        .eraseToAnyPublisher()
    }
    
    func logout() {
        
    }
}

extension AppleOAuthRepository: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            queue.async { [weak self] in
                guard let self = self else { return }
                
                guard let authorizationCode = appleIDCredential.authorizationCode,
                      let identityTokne = appleIDCredential.identityToken else { return }
                
                let fullName = appleIDCredential.fullName?.formatted() ?? ""
                let email = appleIDCredential.email ?? ""
                
                let token = String(data: identityTokne, encoding: .utf8)!
                let code = String(data: authorizationCode, encoding: .utf8)!
                
                // TODO: Server 연결
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                    let hasUserData = Bool.random()
                    
                    if true {
                        let user = UserInfo(id: "123", nickname: "전성훈")
                        
                        self.loginCompletion?(user)

                    } else {
                        let error = NSError(domain: "Server Error", code: 404)
                        
                    }
                }
                print("full name: \(fullName)")
                print("email: \(email)")
                print("identityTokne: \(token)")
                print("authorizationCode: \(code)")
                
                
            }

        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        errorCompletion?()
    }
}
