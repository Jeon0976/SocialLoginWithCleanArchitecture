//
//  SocialLoginOAtuhRepository.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/27/24.
//

import Combine

protocol SocialLoginOAtuhRepository {
    func login() -> AnyPublisher<Void, Error>
    func logout()
}
