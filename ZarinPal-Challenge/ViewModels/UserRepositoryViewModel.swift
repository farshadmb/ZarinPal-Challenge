//
//  UserRepositoryViewModel.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import Combine
import RxSwift

class UserRepositoryViewModel : ObservableObject, Identifiable {
    
    @Published var id: String? = nil
    @Published var title: String? = nil
    @Published var description: String? = nil
    @Published var starCount: Int = 0
    @Published var forkCount: Int = 0
    @Published var avatarImage: URL? = nil
    @Published var languageName: String? = nil
    @Published var languageColor: UIColor = nil
    
    let userRepositoryUseCases: GitHubUserRepositoryUseCases
    let model: Repository
    
    init(repository: Repository, userRepositoryUseCases: GitHubUserRepositoryUseCases) {
        self.model = repository
        self.userRepositoryUseCases = userRepositoryUseCases
        initValues()
    }
    
    func initValues() {
        
        id = model.id
        title = model.name
        description = model.description
        starCount = model.starCount
        forkCount = model.forkCount
        avatarImage = model.avatarImage
        languageName = model.language?.name
        
        if let color = model.language?.color {
            languageColor = UIColor.init(hex: color)
        }
        
    }
    
}
