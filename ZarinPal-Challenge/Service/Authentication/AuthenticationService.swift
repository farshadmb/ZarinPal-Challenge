//
//  AuthenticationLayer.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift

private let credentialKey =  "github-token"

final class AuthenticationService : AuthenticationInterceptable {
    
    private let authenticated = BehaviorSubject<Bool>(value: false)
    
    var isAuthenticated: Observable<Bool> {
        return authenticated.asObservable()
    }
    
    let networkService: NetworkService
    let storage: SecureStorage
    
    private let disposeBag = DisposeBag()
    
    private var internalRequestInterceptor: AuthenticationInterceptor<AuthenticationService>!
    
    deinit {
        internalRequestInterceptor = nil
    }
    
    init(networkService: NetworkService = APIClient.instance,
         storage: SecureStorage = KeyChainStorage(supportsSecureStore: true)) {
        self.networkService = networkService
        self.storage = storage
        
        self.internalRequestInterceptor = AuthenticationInterceptor(authenticator: self)
        authenticated.onNext(loadCredentialFromDisk() != nil)
    }
    
    func buildAuthentication(credential: AppClientCredential) -> Observable<URL?> {
        
        guard let url = URL(string:"https://github.com/login/oauth/authorize") else {
            return .just(nil)
        }
        
        do {
            let urlRequest = try URLRequest(url: url, method: .get)
            
            let request = try URLEncodedFormParameterEncoder.default.encode(credential, into: urlRequest)
                
            guard let outputURL = request.url else {
                return .just(nil)
            }
            
            let url = try outputURL.asURL()
            
            return .just(url)
        }
        catch let error {
            return .error(error)
        }
    }
    
    func requestAccessToken(with code: String, client credential: AppClientCredential) -> Observable<Bool> {
        
        let endpoint = "https://github.com/login/oauth/access_token"
        let newCredential = AppClientCredential(id: credential.id,
                                            secret: credential.secret,
                                            scope: credential.scope, state: credential.state,
                                            redirectURL: credential.redirectURL, code: code)
        
        let source = networkService.executeRequest(endpoint: endpoint,
                                                   parameter:newCredential,
                                                   headers: ["Accept":"application/json"])
            
            .map { (value: Result<OAuthCredential,Error>) -> OAuthCredential in
                switch value {
                case .success(let mapped):
                    print(mapped)
                    return mapped
                case .failure(let error):
                    throw error
                }
                
        }
        .map(save(tokenInfo:))
        return source
    }
    
    private func save(tokenInfo: OAuthCredential) -> Bool {
        internalRequestInterceptor.credential = tokenInfo
        authenticated.onNext(true)
        return self.storage.store(object: tokenInfo, forKey: credentialKey)
    }
    
    private func loadCredentialFromDisk() -> OAuthCredential? {
        internalRequestInterceptor.credential = storage.retreive(type: OAuthCredential.self, forKey:credentialKey)
        return internalRequestInterceptor.credential
    }
    
}

extension AuthenticationService  {
    
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        internalRequestInterceptor.adapt(urlRequest, for: session, completion: completion)
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        internalRequestInterceptor.retry(request, for: session, dueTo: error, completion: completion)
    }
    
}
