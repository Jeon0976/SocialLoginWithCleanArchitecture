//
//  ViewController.swift
//  SocialLoginFeatureWithCleanArchitecture
//
//  Created by 전성훈 on 8/21/24.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
    private var viewModel: LoginViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    private let welcomeLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.text = "환영합니다."
        lbl.font = .systemFont(ofSize: 15, weight: .bold)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private var loginButtons: [UIButton] = []
    
    static func create(
        viewModel: LoginViewModel
    ) -> LoginViewController {
        let viewController = LoginViewController()
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttribute()
        setLayout()
        bindViewModel()
    }
    
    private func setAttribute() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        loginButtons = viewModel.createLoginButtons()
            .map { createLoginButton(for: $0) }
        
        [
            welcomeLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            welcomeLabel.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor
            )
        ])
        
        setupLoginButtonConstraints()
    }
    
    private func createLoginButton(for type: LoginButton)
    -> UIButton {
        let button = UIButton(type: .system)
        
        button.setTitle("Sign in with \(type.title)", for: .normal)
        button.setTitleColor(type.titleColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = type.backgroundColor
        button.layer.cornerRadius = 16
        button.tag = type.hashValue
        button.addTarget(
            self,
            action: #selector(loginButtonTapped(_:)),
            for: .touchUpInside
        )
        
        return button
    }
    
    private func setupLoginButtonConstraints() {
        var previousButton: UIButton?
        
        loginButtons.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
                $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
                $0.heightAnchor.constraint(equalToConstant: 55)
            ])
            
            if let previousButton = previousButton {
                $0.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 16).isActive = true
            } else {
                $0.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 32).isActive = true
            }
            
            previousButton = $0
        }
    }

    private func bindViewModel() {
        viewModel.$selectedLoginButton
            .sink { [weak self] loginType in
                guard let loginType = loginType else { return }
                
                print("Login button Tapped: \(loginType.title)")
            }
            .store(in: &cancellables)
    }
    
    @objc private func loginButtonTapped(_ sender: UIButton) {
        guard let loginType = LoginButton.allCases
            .first(where: { $0.hashValue == sender.tag }) else {
            return }
        
        viewModel.handleLoginButtonTapped(for: loginType)
    }
}

