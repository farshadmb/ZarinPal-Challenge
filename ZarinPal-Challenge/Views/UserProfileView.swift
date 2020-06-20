//
//  UserProfileView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage
import Combine

struct UserProfileView: View {
    
    @ObservedObject var viewModel : UserProfileViewModel
    
    
    var body: some View {
        
        view(forState: viewModel.state)
            .navigationBarTitle("Profile")
    }
    
    func view(forState state : UserProfileViewModel.State) -> some View {
        
        switch state {
        case .idle:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(ActivityIndicator(isAnimating: .constant(true), style: .medium))
        case .error:
            return AnyView(
                viewModel.error.map { error in
                    Group {
                        Text(error.localizedDescription)
                            .fontWeight(.medium)
                            .font(.system(.headline))
                            .padding(.bottom,5)
                        
                        Button(action: {
                            self.viewModel.fetchUserProfileAndMap()
                        }) {
                            Text("Retry")
                                .foregroundColor(.white)
                                .font(.callout)
                        }
                        .padding(16)
                        .background(Color.blue)
                        .clipShape(Capsule())
                    }
                }
            )
        case .loaded:
            return AnyView(
                ScrollView(.vertical, showsIndicators: true) {
                    
                    VStack(alignment: .leading, spacing: 5.0) {
                        UserProfileHeaderView(name: viewModel.name, username: viewModel.username,avatarURL: viewModel.avatarURL)
                        
                        UserProfileDetailRowView(title: "Email:", value: viewModel.email)
                        UserProfileDetailRowView(title: "Company:",value: viewModel.company)
                        UserProfileDetailRowView(title: "Website:", value: viewModel.websiteURL)
                        UserProfileDetailRowView(title: "Bio:", value: viewModel.bio)
                        UserProfileDetailRowView(title: "GitHub:", value: viewModel.url)
                        
                    }
                    .padding()
                }
            )
        }
        
    }
    
}

struct UserProfileHeaderView: View {
    
    @State var name: String = ""
    @State var username: String = ""
    @State var avatarURL: URL? = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            
            KFImage(avatarURL,options: [.forceRefresh,.transition(.fade(0.3))])
                .resizable()
                .onSuccess { r in
                    print(r)
            }
            .placeholder {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75, alignment: .topLeading)
                    .foregroundColor(.green)
                    .clipShape(Circle())
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 75, height: 75, alignment: .topLeading)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .fontWeight(.medium)
                    .font(.system(.headline))
                Text(username)
                    .fontWeight(.light)
                    .font(.system(.subheadline))
                Spacer()
            }
            Spacer(minLength: 1)
            
        }
        .padding()
    }
}


struct UserProfileDetailRowView : View {
    
    @State var title: String? = nil
    @State var value: String? = nil
    var body: some View {
        
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                title.map({
                    Text($0)
                        .fontWeight(.light)
                        .font(.system(.callout))
                })
                value.map({
                    Text($0)
                        .fontWeight(.regular)
                        .font(.system(.footnote))
                        .lineLimit(0)
                })
            }
            Spacer()
        }
        .padding()
    }
    
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(viewModel: .init(userProfileUseCases: AppDIContainer.userProfileUseCases))
    }
}
