//
//  UserRepositoryListViewModel.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import Combine
import RxSwift

class UserRepositoryListViewModel : ObservableObject{
    
    @Published var items: [UserRepositoryViewModel] = []
    @Published var state: State = .idle
    
    enum State {
        case idle
        case loading
        case loadingMore
        case loaded
        case error(Error)
    }
    
    enum Event {
        case fetchRepositories(last: Int)
        case fetchMoreRepositories
        case refresh
    }
    
    let githubRepository: GitHubUserRepositoryUseCases
    
    let disposeBag = DisposeBag()
    
    init(repositoriesUseCase: GitHubUserRepositoryUseCases) {
        self.githubRepository = repositoriesUseCase
    }
    
    func send(event: Event) {
        
        switch event {
        case .fetchRepositories(last: let value):
            state = .loading
            githubRepository.fetchRepositories(last: value)
                .observeOn(MainScheduler.asyncInstance)
                .debug()
                .subscribe {[weak self] (event) in
                    switch event {
                    case .next(let items):
                        self?.items = items.map {
                            UserRepositoryViewModel(repository: $0, userRepositoryUseCases: AppDIContainer.userRepositoryUseCases)
                        }.reversed()
                    case .error(let error):
                        self?.state = .error(error)
                    case .completed:
                        self?.state = .loaded
                    }
            }.disposed(by: disposeBag)
            
        case .fetchMoreRepositories:
            state = .loadingMore
            
            githubRepository.fetchMoreRepositories()
                .observeOn(MainScheduler.asyncInstance)
                .debug()
                .subscribe {[weak self] (event) in
                    switch event {
                    case .next(let newItems):
                        guard let `self` = self else {
                            break
                        }
                        
                        let mapped = newItems.map {
                            UserRepositoryViewModel(repository: $0, userRepositoryUseCases: AppDIContainer.userRepositoryUseCases)
                        }
                        .filter { item in
                            !self.items.contains(where: { $0.model.id == item.model.id })
                        }
                        .reversed() as Array
                        
                        self.items += mapped
                        
                    case .error(let error):
                        self?.state = .error(error)
                    case .completed:
                        self?.state = .loaded
                    }
            }.disposed(by: disposeBag)
            
        case .refresh:
            print("not implemented due the deadline time.")
        }
        
    }
    
}
