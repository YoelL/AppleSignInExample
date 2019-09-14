//
//  AppleSigninProtocol.swift
//  AppleSignInExample
//
//  Created by Yoel Lev on 13/09/2019.
//  Copyright © 2019 Yoel Lev. All rights reserved.
//

import Foundation
import AuthenticationServices

@objc protocol HandleAppleSignInDelegate {
    @objc func handleAuthorizationButtonPress()
}

protocol AppleSignInInterface: ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding  {
    func addAppleSignIn(delegate: HandleAppleSignInDelegate)
}

extension AppleSignInInterface where Self: UIViewController {
    
    func addAppleSignIn(delegate: HandleAppleSignInDelegate) {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.addTarget(self, action: #selector(delegate.handleAuthorizationButtonPress), for: .touchUpInside)

         view.addSubview(appleButton)
         NSLayoutConstraint.activate([
             appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
             appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    func didTapAppleButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}
