//
//  LoginButton.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/28/24.
//

import UIKit

enum LoginButton: CaseIterable {
    case apple
    case google
    case line
    case x
    case facebook
    
    var title: String {
        switch self {
        case .apple:
            "Apple"
        case .google:
            "Google"
        case .line:
            "Line"
        case .x:
            "X"
        case .facebook:
            "Facebook"
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .apple:
                .white
        case .google:
                .white
        case .line:
                .white
        case .x:
                .white
        case .facebook:
                .white
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .apple:
                .black
        case .google:
                .lightGray
        case .line:
                .systemGreen
        case .x:
                .black
        case .facebook:
                .systemBlue
        }
    }
}
