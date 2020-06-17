//
//  BaseRepository.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation


class BaseRepository {
    
    private(set) var storage: Storage?
    private(set) var authenticator: AuthenticationInterceptable?
    private(set) var networkService: NetworkService?
    
    init(storage: Storage? = nil, network: NetworkService? = nil, authenticator: AuthenticationInterceptable? = nil) {
        self.storage = storage
        self.authenticator = authenticator
        self.networkService = network
    }
    
}
