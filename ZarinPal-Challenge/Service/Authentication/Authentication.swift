//
//  Authentication.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol Authentication {
    
    var isAuthenticated: Observable<Bool> { get }
    
    func buildAuthentication(credential: AppClientCredential) -> Observable<URL?>
    
    func requestAccessToken(with code: String, client credential: AppClientCredential) -> Observable<Bool>
    
}

protocol AuthenticationInterceptable : Authentication, RequestInterceptor {
    
}
