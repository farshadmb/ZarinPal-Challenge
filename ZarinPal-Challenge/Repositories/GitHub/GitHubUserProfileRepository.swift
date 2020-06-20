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


final class GitHubUserProfileRepository<UP: Storable>: BaseRepository, GitHubUserProfileRepositoryUseCases {
    
    required init(authenticator: AuthenticationInterceptable, networkService: NetworkServiceInterceptable) {
        networkService.addingRequest(interceptor: authenticator)
        super.init(storage: nil, network: networkService, authenticator: authenticator)
    }
    
    func fetchUserProfile<T: Storable>() -> Observable<T> {
        let query = GitHubGraphQLFactory.profileQuery()
        
        guard let networkService = networkService else {
            return .empty()
        }
        
        return networkService.executeRequest(endpoint: "graphql", query: query, headers: [:])
            .map(map(response:))
            .filter { $0 != nil }
            .map { $0! }
    }
    
    
    private func map<T: Storable>(response : Result<GraphQLResponse<UP>,Error>) throws -> T? {
        return try response.get().data as? T
    }
    
    
    func logoutUser() {
        fatalError("not implemented due the time issue.")
    }
    
}
