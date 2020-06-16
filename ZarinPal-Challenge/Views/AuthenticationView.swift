//
//  AuthenticationView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI

struct AuthenticationView: View  {
    
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
                UIApplication.shared.openURL(URL(string: "https://www.google.com")!)
            }) {
                Text("Authenticate")
                    .foregroundColor(.white)
                    .font(.callout)
            }
            .padding(16)
            .background(Color.blue)
            .clipShape(Capsule())
            
            Spacer()
        }
        .padding(16)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
