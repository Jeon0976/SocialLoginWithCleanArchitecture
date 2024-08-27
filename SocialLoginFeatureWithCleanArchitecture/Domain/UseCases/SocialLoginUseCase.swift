//
//  SocialLoginUseCase.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/22/24.
//

import Foundation

protocol SocialLoginUsecase {
    
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
    
}
