//
//  KeyChainStorage.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import KeychainAccess

fileprivate let serviceName = "com.ifarshad.ZarinPal-Challenge"

struct KeyChainStorage: SecureStorage {
    
    private(set)var supportsSecureStore: Bool
    
    private var keychain : Keychain
    
    init(supportsSecureStore: Bool, keychain : Keychain = Keychain(server: serviceName, protocolType: .https)) {
        self.keychain = keychain.synchronizable(true)
        self.supportsSecureStore = supportsSecureStore
    }
    
    func store<T>(object: T, forKey key: String) -> Bool where T : Storable  {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(object)
            
            guard supportsSecureStore else {
                UserDefaults.standard.setValue(object, forKey:key)
                return UserDefaults.standard.synchronize()
            }
            
            try keychain.set(data, key: key)
            
            return true
        }catch let error {
            print("#function ->",error)
            return false
        }
    }
    
    func retreive<T>(type: T.Type, forKey key: String) -> T? where T : Storable {
        
        do {
            let data : Data?
            
            if supportsSecureStore {
                data = try keychain.getData(key)
            }else {
                data = UserDefaults.standard.data(forKey: key)
            }
            
            guard let objectData = data else {
                 return nil
            }
            
            let decoder = PropertyListDecoder()
            let object = try decoder.decode(T.self, from: objectData)
            
            return object
            
        }catch {
            print("#function ->",error)
            return nil
        }
        
    }
    
}
