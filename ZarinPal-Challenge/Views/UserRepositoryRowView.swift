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
            }
            Spacer()
        }
        .padding(8)
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

}

/*
 struct UserRepositoryRowView_Previews: PreviewProvider {
 static var previews: some View {
 UserRepositoryRowView(viewModel: UserRepositoryViewModel(repository: Repository, userRepositoryUseCases: <#T##GitHubUserRepositoryUseCases#>))
 }
 }
 */
