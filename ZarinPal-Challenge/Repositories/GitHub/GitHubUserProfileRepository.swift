//
//  GitHubUserProfileRepository.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift

protocol GitHubUserProfileRepositoryUseCases {
    
    func fetchUserProfile<T: Storable>() -> Observable<T>
    
    func logoutUser()
    
}


final class GitHubUserProfileRepository: BaseRepository, GitHubUserProfileRepositoryUseCases {
    
    func fetchUserProfile<T>() -> Observable<T> where T : Storable {
        .empty()
    }
    
    func logoutUser() {
        
    }
    
}
