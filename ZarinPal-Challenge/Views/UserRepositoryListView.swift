//
//  UserRespositoryListView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI

struct UserRepositoryListView: View  {
    
    @ObservedObject var viewModel: UserRepositoryListViewModel
    
    @State private var selectProfile : Bool = false
    @State private var previewError: Bool = false
    @State private var error: Error? = nil
    
    var body : some View {
        
        NavigationView {
            Group {
                NavigationLink(destination: UserProfileView(),isActive: self.$selectProfile) {
                    EmptyView()
                }
                .hidden().frame(width: 0, height: 0.0, alignment: .center)
                view(forState: viewModel.state)
            }
            .onAppear(perform: observerState)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle(Text("Repositories"))
            .navigationBarItems(trailing:Button.init(action: {
                self.selectProfile.toggle()
            }, label: {
                Image(systemName: "person.circle").renderingMode(.template).accentColor(.green)
            }))
                .alert(isPresented: self.$previewError) {
                    Alert(title: Text("Error"),
                          message: Text(self.error!.localizedDescription),
                          dismissButton: .default(Text("Got it!")))
            }
        }
        
    }
    
    func view(forState state : UserRepositoryListViewModel.State) -> some View {
        
        switch state {
        case .idle:
            return AnyView(EmptyView())
            
        case .loading:
            return AnyView(ActivityIndicator(isAnimating: .constant(true), style: .medium))
        case .loadingMore,.error(_):
            fallthrough
        case .loaded:
            return AnyView(List(viewModel.items) {  itemViewModel in
                NavigationLink(destination: UserRepositoryDetailView(viewModel: itemViewModel)) {
                    UserRepositoryRowView(viewModel: itemViewModel)
                        .onAppear {
                            
                            if let lastItem = self.viewModel.items.last,
                                lastItem === itemViewModel {
                                self.viewModel.send(event: .fetchMoreRepositories)
                            }
                    }
                }
            })
        }
        
    }
    
    func observerState() {
        
        switch viewModel.state {
        case .idle:
            viewModel.send(event: .fetchRepositories(last: 15))
        case .loading, .loadingMore:
            break
        case .loaded:
            break
        case .error(let error):
            self.error = error
            self.previewError.toggle()
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
        UserRepositoryListView(viewModel: .init(repositoriesUseCase: AppDIContainer.userRepositoryUseCases))
    }
}
