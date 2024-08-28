//
//  TwitterOAuthRepository.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/22/24.
//

import Combine

final class TwitterOAuthRepository {
    
}

extension TwitterOAuthRepository: SocialLoginOAtuhRepositoryInterface {
    func login() -> AnyPublisher<UserInfo, Error> {
        return Future { promise in
            
        }
        .eraseToAnyPublisher()
    }
    
    func logout() {
        
    }
}
