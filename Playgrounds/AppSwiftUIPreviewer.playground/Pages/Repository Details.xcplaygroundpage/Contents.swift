//: [Previous](@previous)

import Foundation
import SwiftUI
import UIKit
import PlaygroundSupport


struct FirstPage : View {
    
    @State var isModalSheetShown: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 8) {
                Spacer()
                NavigationLink(destination: RepositoryDetailView()) {
                    Text("Go to Repo Detail")
                        .font(.system(.headline))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(16)
                        .background(Color.green)
                        .clipShape(Capsule())
                }
                Spacer()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("FirstPage")
        }
    }
}

struct RepositoryDetailView : View {
    
    enum RepositoryDetailMode : String, CaseIterable {
        case branch = "Branch"
        case issues = "Issues"
        case pullRequest = "Pull Request"
    }
    
    @State var mode : RepositoryDetailMode = .branch
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack(alignment: .center, spacing: 8) {
                ForEach(RepositoryDetailMode.allCases, id:\.rawValue) { mode in
                    Button(action: {
                        self.mode = mode
                    }) {
                        Text(mode.rawValue)
                            .font(.system(.headline))
                            .fontWeight(.medium)
                            .foregroundColor( self.mode == mode ? .blue : .gray)
                    }
                }
            }
            buildListView(items: [])
            Spacer()
        }
        .navigationBarTitle("Detailview",displayMode: .inline)
        
    }
    
    func buildListView(items : [String]) -> some View {
        var items = items
        if items.isEmpty {
            items = Array(repeating: self.mode.rawValue, count: 20
        }
        
        switch self.mode {
        case .branch:
            return List(items, id: \.self) { item in
                Text(item)
                    .font(.system(.headline))
                    .fontWeight(.medium)
            }
        case .pullRequest:
            return List(items, id: \.self) { item in
                Text(item)
                    .font(.system(.body))
                    .fontWeight(.medium)
            }
        case .issues:
            return List(items, id: \.self) { item in
                Text(item)
                    .font(.system(.subheadline))
                    .fontWeight(.medium)
            }
        }
    }
}
let view = FirstPage()

// Present the view controller in the Live View window
PlaygroundPage.current.setLiveView(view)
PlaygroundPage.current.needsIndefiniteExecution = true


//: [Next](@next)
