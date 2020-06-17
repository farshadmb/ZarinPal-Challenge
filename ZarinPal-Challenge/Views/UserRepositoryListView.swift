//
//  UserRespositoryListView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI

struct UserRepositoryListView: View  {
    
    var items : [RepositoryData]
    var body : some View {
        
        NavigationView {
            List(items) { item in
                NavigationLink(destination: UserRepositoryDetailView(data:item)) {
                    UserRepositoryRowView(repository: item)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
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

struct UserRepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        UserRepositoryListView(items: [])
    }
}
