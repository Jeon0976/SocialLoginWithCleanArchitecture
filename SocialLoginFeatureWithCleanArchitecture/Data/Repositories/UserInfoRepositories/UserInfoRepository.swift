//
//  UserInfoRepository.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/28/24.
//

import Combine

final class UserInfoRepository {
    
}

extension UserInfoRepository: UserInfoRepositoryInterface {
    func saveUser(
        _ user: UserInfo
    ) -> AnyPublisher<Void, Error> {
        return Future { promise in
            
        }
        .eraseToAnyPublisher()
    }
}
