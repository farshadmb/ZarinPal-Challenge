//
//  Storage.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

protocol Storage {
    
    /// <#Description#>
    /// - Parameters:
    ///   - object: <#object description#>
    ///   - forKey: <#forKey description#>
    func store<T: Storable> (object: T, forKey key: String) -> Bool
    
    /// <#Description#>
    /// - Parameters:
    ///   - type: <#type description#>
    ///   - forKey: <#forKey description#>
    func retreive<T: Storable>(type:T.Type, forKey key: String) -> T?
    
}

protocol SecureStorage: Storage {
    
    var supportsSecureStore: Bool { get }
}
