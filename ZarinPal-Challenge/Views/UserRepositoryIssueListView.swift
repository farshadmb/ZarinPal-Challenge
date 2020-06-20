//
//  UserRepositoryIssueListView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI

struct UserRepositoryIssueListView: View {
    @Binding var issues : [RepositoryData.IssueData]
    var body: some View {
        List(issues) { item in
            UserRepositoryIssueRowView(issue: item)
        }
    }
}

struct UserRepositoryIssueRowView: View {
    
    @State var issue: RepositoryData.IssueData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(issue.title)
                .font(.system(.headline, design: .serif))
                .fontWeight(.semibold)
            Text(issue.number)
                .font(.system(.body, design: .serif))
                .fontWeight(.regular)
            Text(issue.description)
                .font(.system(.body, design: .serif))
                .fontWeight(.regular)
        }
        .padding()
    }
}

struct UserRepositoryIssueListView_Previews: PreviewProvider {
    static var previews: some View {
        UserRepositoryIssueListView(issues: .constant([]))
    }
}
