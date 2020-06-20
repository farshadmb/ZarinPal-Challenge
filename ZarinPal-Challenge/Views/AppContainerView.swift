//
//  AppContainerView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI
import UIKit
import Combine
struct AppContainerView: View {
    
    @ObservedObject var viewModel : AppViewModel
    
    var body: some View {
        
        switch viewModel.state {
        case .authorized:
            return AnyView(UserRepositoryListView(items: []))
        case .notAuthorized:
            return AnyView(AuthenticationView(viewModel: AuthenticationViewModel(authentication: viewModel.authentication)))
        }
        
    }
}


struct AppContainerView_Previews: PreviewProvider {
    static var previews: some View {
        AppContainerView(viewModel: AppViewModel(authentication: AppDIContainer.authenticationUseCases))
    }
}

