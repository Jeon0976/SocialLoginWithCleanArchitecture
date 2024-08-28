//
//  UserRepository.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/28/24.
//

import Combine

protocol UserInfoRepositoryInterface {
    func saveUser(_ user: UserInfo) -> AnyPublisher<Void, Error>
}
