//
//  UserProfileViewModel.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import Combine
import RxSwift

class UserProfileViewModel : ObservableObject, Identifiable {
    
    
    @Published var id: String = ""
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var email: String? = nil
    @Published var avatarURL: URL? = nil
    @Published var url: String? = nil
    @Published var twitterUsername: String? = nil
    @Published var bio: String? = nil
    @Published var company: String? = nil
    @Published var websiteURL: String? = nil
    
    @Published var state: State = .idle
    @Published var error: Error? = nil
    
    enum State {
        case idle
        case loading
        case loaded
        case error
    }
    
    let userProfileUseCases: GitHubUserProfileRepositoryUseCases
    
    let disposeBag = DisposeBag()
    
    init(userProfileUseCases: GitHubUserProfileRepositoryUseCases) {
        self.userProfileUseCases = userProfileUseCases
        fetchUserProfileAndMap()
    }
    
    func fetchUserProfile() -> Observable<UserProfile> {
        userProfileUseCases.fetchUserProfile()
    }
    
    func fetchUserProfileAndMap() {
        state = .loading
        fetchUserProfile()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe {[weak self] (event) in
                switch event {
                case .next(let profile):
                    self?.assign(userProfile: profile)
                case .error(let error):
                    self?.state = .error
                    self?.error = error
                case .completed:
                    self?.state = .loaded
                }
        }
        .disposed(by: disposeBag)
    }
    
    /// <#Description#>
    /// - Parameter userProfile: <#userProfile description#>
    func assign(userProfile: UserProfile) {
        name = userProfile.name ?? userProfile.username
        username = "@"+userProfile.username
        id = userProfile.id
        email = userProfile.email
        
        if let imageURL = userProfile.avatarURL {
            avatarURL = URL(string: imageURL)
        }
        
        bio = userProfile.bio
        company = userProfile.company
        
        websiteURL = userProfile.websiteURL
        
    }
    
    
}
