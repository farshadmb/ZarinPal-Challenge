//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import SwiftUI
import Combine
import Foundation
import UIKit

struct RespositoryData: Identifiable {
    
    var id: String {
        return title
    }
    
    var title: String
    var description: String?
    
}


struct UserRepositoryRowView: View {
    
    @Binding var repository : RespositoryData
    var body: some View {
        HStack (alignment: .center, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                Text(repository.title)
                    .font(.system(.headline, design: .serif))
                    .fontWeight(.semibold)
                repository.description.map({
                    Text($0)
                        .font(.system(.body, design: .serif))
                        .fontWeight(.regular)
                })
                
            }
            
            NavigationLink("", destination: TempView())
        }
        .padding()
    }
}


struct UserRepositoryListView: View  {
    
    @Binding var items : [RespositoryData]
    var body : some View {
        
        NavigationView {
            List(items) { item in
                UserRepositoryRowView(repository: .constant(item))
            }
            .navigationBarTitle("Repositories")
            .navigationBarItems(trailing:  NavigationLink(destination: EmptyView()) {
                       Image(systemName: "person.circle")
                   }.accentColor(.green))
        }
        
    }
    
}

struct TempView : View {
    var body: some View {
        Text("Hello View")
    }
}

var items = [RespositoryData]()

for i in 0...20 {
    
    let respository = RespositoryData(title: "Repo Name \(i)", description: i % 2 == 0 ? nil : "Repo Desc")
    items.append(respository)
}

let view = UserRepositoryListView(items: .constant(items))

// Present the view controller in the Live View window
PlaygroundPage.current.setLiveView(view)
PlaygroundPage.current.needsIndefiniteExecution = true
