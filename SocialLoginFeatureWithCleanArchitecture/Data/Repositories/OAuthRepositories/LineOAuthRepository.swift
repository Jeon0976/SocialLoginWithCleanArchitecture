//
//  LineOAuthRepository.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/22/24.
//

import Combine

import LineSDK

final class LineOAuthRepository {
    
}

extension LineOAuthRepository: SocialLoginOAtuhRepositoryInterface {
    func login() -> AnyPublisher<UserInfo, Error> {
        return Future { promise in
            
        }
        .eraseToAnyPublisher()
    }
    
    func logout() {
        
    }
}
