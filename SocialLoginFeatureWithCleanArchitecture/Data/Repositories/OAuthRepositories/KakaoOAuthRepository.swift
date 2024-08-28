//
//  KakaoOAuthRepository.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/22/24.
//

import Combine

final class KakaoOAuthRepository {
    
}

extension KakaoOAuthRepository: SocialLoginOAtuhRepository {
    func login() -> AnyPublisher<Void, Error> {
        return Future { promise in
            
        }
        .eraseToAnyPublisher()
    }
    
    func logout() {
        
    }
}
