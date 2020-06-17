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
    @State private var selectProfile : Bool = false
    var body : some View {
        
        NavigationView {
            Group {
                NavigationLink(destination: UserProfileView(),isActive: self.$selectProfile) {
                    EmptyView()
                }
                .hidden().frame(width: 0, height: 0, alignment: .center)
                List(items) { item in
                    NavigationLink(destination: UserRepositoryDetailView(data:item)) {
                        UserRepositoryRowView(repository: item)
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle(Text("Repositories"))
            .navigationBarItems(trailing:Button.init(action: {
                self.selectProfile.toggle()
            }, label: {
                Image(systemName: "person.circle").renderingMode(.template).accentColor(.green)
            }))
        }
        
    }
    
}

struct TempView : View {
    var body: some View {
        NavigationLink(destination: UserProfileView()) {
            Image(systemName: "person.circle").accentColor(.green)
        }
    }
}

struct UserRepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        UserRepositoryListView(items: [])
    }
}
