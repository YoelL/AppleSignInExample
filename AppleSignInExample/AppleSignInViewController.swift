//
//  AppleSignInViewController.swift
//  AppleSignInExample
//
//  Created by Yoel Lev on 13/09/2019.
//  Copyright © 2019 Yoel Lev. All rights reserved.
//

import UIKit
import AuthenticationServices

class AppleSignInViewController: UIViewController {
    
    let infoLabelPadding: CGFloat = 50
    
    lazy var signInInfoLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
        
    }()
    
    //MARK: iOS Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addAppleSignIn(delegate: self)
        setupInfoLabel()
    }
    
    //MARK: Setup UI Label
    func setupInfoLabel() {
        view.addSubview(signInInfoLbl)
        NSLayoutConstraint.activate([
            signInInfoLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: infoLabelPadding),
            signInInfoLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -infoLabelPadding),
            signInInfoLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: infoLabelPadding)
        ])
        
    }
}

//MARK: - Apple Sign In Protocol
extension AppleSignInViewController: AppleSignInInterface {

    //MARK: - ASAuthorization Controller Delegate
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        switch authorization.credential {

        case let credentials as ASAuthorizationAppleIDCredential:
            let user = User(credentials: credentials)
            print(user)
            signInInfoLbl.text = "\(user)"
            self.view.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.3916214705, alpha: 1)

        default: break

        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Sign In did fail with error:", error)
    }

    //MARK: ASAuthorization Controller Presentation Context Providing Delegate
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
      }

}


extension AppleSignInViewController: HandleAppleSignInDelegate {
    func handleAuthorizationButtonPress() {
        didTapAppleButton()
    }
}
