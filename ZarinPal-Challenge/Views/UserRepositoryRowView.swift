//
//  UserRepositoryRowView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Combine
import SwiftUI
import struct Kingfisher.KFImage

struct UserRepositoryRowView: View {
    
    @ObservedObject var viewModel : UserRepositoryViewModel
    
    var body: some View {
        Group {
            HStack(alignment: .center, spacing: 8) {
                avatarImage()
                VStack(alignment: .leading, spacing: 5) {
                    viewModel.title.map({
                        Text($0)
                            .fontWeight(.medium)
                            .font(.system(Font.TextStyle.subheadline))
                    })
                    viewModel.description.map({
                        Text($0)
                            .fontWeight(.regular)
                            .font(.system(.caption))
                            .lineLimit(3)
                            .truncationMode(.tail)
                    })
                    
                    HStack(alignment: .bottom, spacing: 2) {
                        languageView()
                        .frame(alignment: .bottomLeading)
                        
                        Spacer()
                        Group {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 10, alignment: .bottom)
                            .foregroundColor(.orange)
                        Text("\(viewModel.starCount)")
                            .fontWeight(.light)
                            .font(.system(size: 8))
                        
                        Image(systemName: "tuningfork")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 10, alignment: .bottom)
                            .foregroundColor(.black)
                        
                        Text("\(viewModel.forkCount)")
                            .fontWeight(.light)
                            .font(.system(size: 8))
                        }
                        .frame(alignment: .bottomTrailing)
                    }
                    
                }
                Spacer()
            }
        }
        .padding(8)
        .listRowInsets(.none)
        
    }
    
    func avatarImage() -> some View {
        return KFImage(viewModel.avatarImage,options: [.forceRefresh,.transition(.fade(0.3))])
            .resizable()
            .onSuccess { r in
                print(r)
        }
        .placeholder {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 45, alignment: .topLeading)
                .foregroundColor(.green)
                .clipShape(Circle())
        }
        .aspectRatio(contentMode: .fit)
        .frame(width: 45, height: 45, alignment: .topLeading)
        .clipShape(Circle())
        
    }
    
    func languageView() -> some View {
        
        viewModel.languageName.map { name in
            
            HStack(alignment: .bottom, spacing: 2) {
                Text("Language:")
                    .fontWeight(.light)
                    .font(.system(size: 8))
                Text(name).fontWeight(.light)
                    .font(.system(size: 8))
                
                viewModel.languageColor.map { color in
                    Circle()
                        .fill(Color(color))
                        .frame(width: 10, height: 10, alignment: .bottom)
                }
            }
        }
    }
    
}

/*
 struct UserRepositoryRowView_Previews: PreviewProvider {
 static var previews: some View {
 UserRepositoryRowView(viewModel: UserRepositoryViewModel(repository: Repository, userRepositoryUseCases: <#T##GitHubUserRepositoryUseCases#>))
 }
 }
 */
