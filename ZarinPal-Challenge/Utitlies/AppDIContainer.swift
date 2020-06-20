//
//  AppDIContainer.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import Alamofire

struct AppDIContainer {
    
    static let clientCredential = AppConfig.clientCredetianl
    
    ////////////////////////////////////////////////////////////////
    //MARK:-
    //MARK:Storage DI Container
    //MARK:-
    ////////////////////////////////////////////////////////////////

    static let secureStorage: SecureStorage = KeyChainStorage(supportsSecureStore: true)
    
    ////////////////////////////////////////////////////////////////
    //MARK:-
    //MARK:Authroization DI Container
    //MARK:-
    ////////////////////////////////////////////////////////////////

    
    static let authorization: Authentication = {
        return authorizationInterceptor
    }()
    
    static let authorizationInterceptor: AuthenticationInterceptable = {
        return AuthenticationService(networkService: APIClient.instance, storage: secureStorage)
    }()
    
    static let networkService: NetworkServiceInterceptable = {
        let session = Session()
        session.sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let apiClient = APIClient(session: session, decoder: APIClient.default.decoder)
        return apiClient
    }()
    
    ////////////////////////////////////////////////////////////////
    //MARK:-
    //MARK:Repository DI Container
    //MARK:-
    ////////////////////////////////////////////////////////////////
    
    static var authenticationRepository : AuthenticationRepository {
        return AuthenticationRepository(authenticator: authorizationInterceptor, clientCredential: clientCredential)
    }
    
    static var githubUserRepository: GitHubUserRepository {
        return GitHubUserRepository(authenticator: authorizationInterceptor, networkService: networkService)
    }
    
    static var githubUserProfileRepository: GitHubUserProfileRepository<UserProfile> {
        return GitHubUserProfileRepository(authenticator: authorizationInterceptor, networkService: networkService)
    }
    
    ////////////////////////////////////////////////////////////////
    //MARK:-
    //MARK:Use Cases DI Container
    //MARK:-
    ////////////////////////////////////////////////////////////////

    static var authenticationUseCases: AuthenticationUseCase {
        return authenticationRepository
    }
    
    static var userRepositoryUseCases: GitHubUserRepositoryUseCases {
        return githubUserRepository
    }
    
    static var userProfileUseCases: GitHubUserProfileRepositoryUseCases {
        return githubUserProfileRepository
    }
    
    
}
