//: [Previous](@previous)

import PlaygroundSupport
import SwiftUI
import Combine
import UIKit

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

let view = AuthenticationView()

// Present the view controller in the Live View window
PlaygroundPage.current.setLiveView(view)
PlaygroundPage.current.needsIndefiniteExecution = true
//: [Next](@next)
