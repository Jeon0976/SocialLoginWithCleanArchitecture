//
//  SocialLoginOAtuhRepository.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/27/24.
//

import Combine

protocol SocialLoginOAtuhRepositoryInterface {
    func login() -> AnyPublisher<UserInfo, Error>
    func logout()
}
