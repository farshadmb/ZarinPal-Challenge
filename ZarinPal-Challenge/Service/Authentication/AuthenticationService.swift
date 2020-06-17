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
    
    func requestClientAuthorize(credential: AppClientCredential) -> Observable<Bool> {
        
        guard let url = URL(string:"https://github.com/login/oauth/authorize") else {
            return .just(false)
        }
        
        do {
            let urlRequest = try URLRequest(url: url, method: .get)
            
            let request = try URLEncodedFormParameterEncoder.default.encode(credential, into: urlRequest)
                
            UIApplication.shared.open(request.url!,
                                      options: [:]) { (result) in
                                        print(result)
            }
            
            return .just(true)
        }
        catch let error {
            return .error(error)
        }
    }
    
    func requestAccessToken(with code: String, client credential: AppClientCredential) -> Observable<Bool> {
        
        let endpoint = "https://github.com/login/oauth/access_token"
        let source = networkService.executeRequest(endpoint: endpoint,
                                                   parameter:credential,
                                                   headers: [:])
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
        return self.storage.store(object: tokenInfo, forKey: "credentialKey")
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
