//
//  FacebookOAuthRepository.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/22/24.
//

import Combine

import FacebookLogin

final class FacebookOAuthRepository {
    
}

extension FacebookOAuthRepository: SocialLoginOAtuhRepository {
    func login() -> AnyPublisher<Void, Error> {
        return Future { promise in
            
        }
        .eraseToAnyPublisher()
    }
    
    func logout() {
        
    }
}
