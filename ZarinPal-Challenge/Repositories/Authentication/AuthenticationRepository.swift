//
//  AuthenticationRepository.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

/// <#Description#>
protocol AuthenticationUseCase : class {
        
    func authorizeUser() -> Observable<Bool>
    
    func fetchCredential(with code: String) -> Observable<Bool>
    
}

final class AuthenticationRepository : BaseRepository, AuthenticationUseCase {
    
    var authorizeStatus: Observable<AuthenticationStatus> {
        return authenticator?
            .isAuthenticated
            .map({ $0 ? AuthenticationStatus.authorized : .notAuthorized}) ?? .just(.unknown)
    }
    
    private let clientCredential: AppClientCredential
    
    required init(authenticator: AuthenticationInterceptable, clientCredential: GitClientCredential) {
        
        self.clientCredential = AppClientCredential(id: clientCredential.id, secret: clientCredential.secret,
                                                    scope: clientCredential.scope, state: clientCredential.state,
                                                    redirectURL: clientCredential.redirectURL)
        
        super.init(storage: nil, network: nil, authenticator: authenticator)
    }
    
    
    func fetchCredential(with code: String) -> Observable<Bool> {
        guard let authenticator = authenticator else {
            return .just(false)
        }
        
        return authenticator.requestAccessToken(with: code, client: clientCredential)
    }
    
    func authorizeUser() -> Observable<Bool> {
        
        guard let authenticator = authenticator else {
            return .just(false)
        }
        
        return authenticator.requestClientAuthorize(credential: clientCredential)
    }
 
}
