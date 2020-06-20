//
//  GitHubUserRepository.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import RxSwift
import AutoGraphQL

protocol GitHubUserRepositoryUseCases {
    
    typealias T = Repository
    
    func fetchRepositories(last: Int) -> Observable<[T]>
    
    func fetchRepository(name: String) -> Observable<T>
    
    func fetchMoreRepositories() -> Observable<[T]>
    
}


final class GitHubUserRepository : BaseRepository, GitHubUserRepositoryUseCases {
    
    private var lastPage: Pagination?
    private var pageSize: Int = 10
    
    required init(authenticator: AuthenticationInterceptable, networkService: NetworkServiceInterceptable) {
        networkService.addingRequest(interceptor: authenticator)
        super.init(storage: nil, network: networkService, authenticator: authenticator)
    }
    
    func fetchRepository(name: String) -> Observable<T> {
        .empty()
    }
    
    func fetchRepositories(last: Int) -> Observable<[T]> {
        
        guard let network = networkService else {
            return .empty()
        }
        
        self.pageSize = last
        
        return fetchRespositories(last:pageSize,
                                  cursor: lastPage?.startCursor,
                                  networkService: network)
        
    }
    
    func fetchMoreRepositories() -> Observable<[T]> {
        
        guard let lastPage = lastPage, lastPage.hasPreviousPage,
            let network = networkService else {
            return .empty()
        }
        
        return fetchRespositories(last:self.pageSize,
                                  cursor: lastPage.startCursor,
                                  networkService: network)
    }
    
    
    ////////////////////////////////////////////////////////////////
    //MARK:-
    //MARK:Private Methods
    //MARK:-
    ////////////////////////////////////////////////////////////////

    
    private typealias GitHubRepositoriesResponse = GraphQLResponse<Repositories>
    
    private func fetchRespositories(last: Int, cursor: String? , networkService :NetworkService ) -> Observable<[T]> {
        
        let query = GitHubGraphQLFactory.repositoriesQuery(last: last, cursor: cursor)
        
        return networkService.executeRequest(endpoint: "graphql", query: query, headers: [:])
            .map(map(response:))
            .map(map(respositories:))
    }
    
    
    private func map(response : Result<GitHubRepositoriesResponse,Error>) throws -> Repositories? {
        return try response.get().data
    }
    
    private func map(respositories: Repositories?) -> [T] {
        let lock = NSLock()
        lock.lock(); defer { lock.unlock() }
        lastPage = respositories?.page
        return respositories?.repositores.compactMap( { $0 }) ?? []
    }
    
}
