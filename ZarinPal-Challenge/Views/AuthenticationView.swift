//
//  AuthenticationView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

struct AuthenticationView: View  {
    
    @ObservedObject var viewModel : AuthenticationViewModel
    
    var body : some View {
        VStack(spacing: 16) {
            Text("Authentication")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Text("The application needs to be authenticated, to show user repositories and present your profile.")
                .fontWeight(.medium)
                .font(.system(.body, design: .monospaced))
            Text("Please Tab on the button to authenticate your self.")
                .font(.body)
                .fontWeight(.semibold)
            Button(action: {
                self.viewModel.send(event: .authorize)
            }) {
                Text("Authenticate")
                    .foregroundColor(.white)
                    .font(.callout)
            }
            .padding(16)
            .background(Color.blue)
            .clipShape(Capsule())
            
            viewModel.error.map { (error) in
                Text(error.localizedDescription)
                    .font(.body)
                    .fontWeight(.regular)
            }
            
            Spacer()
        }
        .padding(16)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(viewModel: AuthenticationViewModel(authentication: AppDIContainer.authenticationUseCases))
    }
}
