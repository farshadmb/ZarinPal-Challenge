//
//  UserRespositoryPullRequestListView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI

struct UserRepositoryPullRequestListView: View {
    @Binding var requestes : [RepositoryData.PullRequestData]
    var body: some View {
        List(requestes) { item in
            UserRepositoryPullRequestRowView(pullRequest: item)
        }
    }
}

struct UserRepositoryPullRequestRowView: View {
    
    @State var pullRequest: RepositoryData.PullRequestData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(pullRequest.title)
                .font(.system(.headline, design: .serif))
                .fontWeight(.semibold)
            Text(pullRequest.number)
                .font(.system(.body, design: .serif))
                .fontWeight(.regular)
            Text(pullRequest.description)
                .font(.system(.body, design: .serif))
                .fontWeight(.regular)
        }
        .padding()
    }
}

struct UserRespositoryPullRequestListView_Previews: PreviewProvider {
    static var previews: some View {
        UserRepositoryPullRequestListView(requestes: .constant([]))
    }
}
