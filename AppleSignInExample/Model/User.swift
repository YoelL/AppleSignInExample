//
//  User.swift
//  AppleSignInExample
//
//  Created by Yoel Lev on 13/09/2019.
//  Copyright © 2019 Yoel Lev. All rights reserved.
//

import Foundation
import AuthenticationServices

struct User {
    
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    
    init(credentials: ASAuthorizationAppleIDCredential) {
        self.id = credentials.user
        self.firstName = credentials.fullName?.givenName ?? "Unknown givenName"
        self.lastName = credentials.fullName?.familyName ?? "Unknown familyName"
        self.email = credentials.email ?? "Unknow email"
    }

}

extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
        ID: \(id)
        First Name: \(firstName)
        Last Name: \(lastName)
        Email: \(email)
        """
    }
}
