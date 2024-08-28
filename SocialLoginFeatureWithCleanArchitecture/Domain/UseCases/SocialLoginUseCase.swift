//
//  SocialLoginUseCase.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/22/24.
//

import Combine

protocol SocialLoginUsecase {
    func login(loginType: LoginType) -> AnyPublisher<Void, Error>
}

final class DefaultSocialLoginUseCase {
    private var appleOAuthRepository: SocialLoginOAtuhRepository!
    private var googleOAuthRepository: SocialLoginOAtuhRepository!
    private var lineOAuthRepository: SocialLoginOAtuhRepository!
    private var twitterOAuthRepository: SocialLoginOAtuhRepository!
    private var facebookOAuthRepository: SocialLoginOAtuhRepository!
    
    static func create(
        appleOAuthRepo: SocialLoginOAtuhRepository,
        googleOAuthRepo: SocialLoginOAtuhRepository,
        lineOAuthRepo: SocialLoginOAtuhRepository,
        twitterOAuthRepo: SocialLoginOAtuhRepository,
        facebookOAuthRepo: SocialLoginOAtuhRepository
    ) -> DefaultSocialLoginUseCase {
        let usecase = DefaultSocialLoginUseCase()
        
        usecase.appleOAuthRepository = appleOAuthRepo
        usecase.googleOAuthRepository = googleOAuthRepo
        usecase.lineOAuthRepository = lineOAuthRepo
        usecase.twitterOAuthRepository = twitterOAuthRepo
        usecase.facebookOAuthRepository = facebookOAuthRepo
        
        return usecase
    }
}

extension DefaultSocialLoginUseCase: SocialLoginUsecase {
    func login(loginType: LoginType) -> AnyPublisher<Void, Error> {
        switch loginType {
        case .apple:
            return appleOAuthRepository.login()
        case .google:
            return googleOAuthRepository.login()
        case .x:
            return twitterOAuthRepository.login()
        case .facebook:
            return facebookOAuthRepository.login()
        case .line:
            return lineOAuthRepository.login()
        }
    }
}
