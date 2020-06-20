//
//  XCAuthenticatorHelper.swift
//  ZarinPal-ChallengeTests
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
@testable import ZarinPal_Challenge
import KeychainAccess

struct AuthenticatorFactory {
    
    static let `default` : AuthenticationService = {
        let keychain = Keychain(server: "com.ifarshad.unittest", protocolType: .https)
        let storage = KeyChainStorage(supportsSecureStore: true, keychain: keychain)
        return AuthenticationService(storage: storage)
    }()
    
    static func createAuthentictorService(storage: SecureStorage) -> AuthenticationService {
        return AuthenticationService(storage: storage)
    }
    
}
