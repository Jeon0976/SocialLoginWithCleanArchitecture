//
//  SocialLoginUseCase.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/22/24.
//

import Foundation
import Combine

protocol SocialLoginUsecaseInterface {
    func login(loginType: LoginType) -> AnyPublisher<Void, Error>
}

final class SocialLoginUseCase {
    private var appleOAuthRepository: SocialLoginOAtuhRepositoryInterface!
    private var googleOAuthRepository: SocialLoginOAtuhRepositoryInterface!
    private var lineOAuthRepository: SocialLoginOAtuhRepositoryInterface!
    private var twitterOAuthRepository: SocialLoginOAtuhRepositoryInterface!
    private var facebookOAuthRepository: SocialLoginOAtuhRepositoryInterface!
    private var userRepository: UserInfoRepositoryInterface!
    
    static func create(
        appleOAuthRepo: SocialLoginOAtuhRepositoryInterface,
        googleOAuthRepo: SocialLoginOAtuhRepositoryInterface,
        lineOAuthRepo: SocialLoginOAtuhRepositoryInterface,
        twitterOAuthRepo: SocialLoginOAtuhRepositoryInterface,
        facebookOAuthRepo: SocialLoginOAtuhRepositoryInterface,
        userRepository: UserInfoRepositoryInterface
    ) -> SocialLoginUseCase {
        let usecase = SocialLoginUseCase()
        
        usecase.appleOAuthRepository = appleOAuthRepo
        usecase.googleOAuthRepository = googleOAuthRepo
        usecase.lineOAuthRepository = lineOAuthRepo
        usecase.twitterOAuthRepository = twitterOAuthRepo
        usecase.facebookOAuthRepository = facebookOAuthRepo
        usecase.userRepository = userRepository
        
        return usecase
    }
}

extension SocialLoginUseCase: SocialLoginUsecaseInterface {
    func login(loginType: LoginType) -> AnyPublisher<Void, Error> {
        let loginPublisher: AnyPublisher<UserInfo, Error>

        switch loginType {
        case .apple:
            loginPublisher = appleOAuthRepository.login()
        case .google:
            loginPublisher = googleOAuthRepository.login()
        case .x:
            loginPublisher = twitterOAuthRepository.login()
        case .facebook:
            loginPublisher = facebookOAuthRepository.login()
        case .line:
            loginPublisher = lineOAuthRepository.login()
        }
        
        return loginPublisher
            .flatMap { [weak self] userInfo in
                guard let self = self else {
                    return Fail<Void, Error>(
                        error: NSError(
                            domain: "UseCase Error",
                            code: 1))
                    .eraseToAnyPublisher()
                }
                
                return self.userRepository.saveUser(userInfo)
            }
            .eraseToAnyPublisher()
    }
}
