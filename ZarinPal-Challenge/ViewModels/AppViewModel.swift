//
//  AppViewModel.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift
import Combine

class AppViewModel: ObservableObject {
    
    @Published var state: State = .notAuthorized
    @Published var error: Error? = nil
    
    enum State {
        case authorized
        case notAuthorized
    }
    
    enum Event {
        case authorize
        case recieved(code: String)
    }
    
    private let authentication : AuthenticationUseCase
    
    let disposeBag = DisposeBag()
    
    init(authentication: AuthenticationUseCase) {
        
        self.authentication = authentication
        observerAuthentication()
    }
    
    func observerAuthentication() {
        
        authentication.authorizeStatus()
            .asObservable()
            .subscribe(onNext: {[unowned self] (status) in
                let newState : State
                
                switch status {
                case .authorized:
                    newState = .authorized
                case .unknown:
                    fallthrough
                case .notAuthorized:
                    newState = .notAuthorized
                }
                
                self.state = newState
            })
        .disposed(by: disposeBag)
        
    }
    
    func send(event: Event) {
        switch event {
        case .authorize:
            authentication.authorizeUser()
                .subscribeOn(MainScheduler.asyncInstance)
                .subscribe {[weak self] (event) in
                    switch event {
                    case .completed:
                        return
                    case .next(let url):
                        self?.open(URL: url)
                    case .error(let error):
                        self?.error = error
                    }
            }
            .disposed(by: disposeBag)
            
        case .recieved(code: let code):
            authentication.fetchCredential(with: code)
            .subscribeOn(MainScheduler.asyncInstance)
                .subscribe {[weak self] (event) in
                    switch event {
                    case .completed:
                        return
                    case .next(_):
                        return
                    case .error(let error):
                        self?.error = error
                    }
            }
            .disposed(by: disposeBag)
        }
    }
    
    func open(URL url : URL?) {
        
        guard let url = url, UIApplication.shared.canOpenURL(url) else {
             return
        }
        
        UIApplication.shared.open(url,
                                  options: [:]) { (result) in
                                    
        }
        
    }
    
    
}
