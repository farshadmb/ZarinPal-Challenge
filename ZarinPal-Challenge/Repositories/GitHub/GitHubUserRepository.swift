//
//  GitHubUserRepository.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift

protocol GitHubUserRepositoryUseCases {
    
    associatedtype T : Storable
    
    func fetchRepositories(last: Int) -> Observable<[T]>
    
    func fetchRepository(id: Int) -> Observable<T>
    
}


final class GitHubUserRepository <G: Storable>: BaseRepository, GitHubUserRepositoryUseCases {
    
    typealias T = G
    
    func fetchRepository(id: Int) -> Observable<T> {
        .empty()
    }
    
    func fetchRepositories(last: Int) -> Observable<[T]> {
        .empty()
    }
    
}
