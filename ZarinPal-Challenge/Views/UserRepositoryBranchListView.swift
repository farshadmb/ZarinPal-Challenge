//
//  UserRepositoryBranchListView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI
import Combine

struct UserRepositoryBranchListView: View {
    
    @Binding var listItem : [RepositoryData.BranchData]
    
    var body: some View {
        List(listItem) { item in
            UserRepositoryBranchRowView(branch: item)
        }
    }
}

struct UserRepositoryBranchRowView: View {
    @State var branch : RepositoryData.BranchData
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(branch.title)
                .font(.system(.headline, design: .serif))
                .fontWeight(.semibold)
            Text(branch.createdDate.description)
                .font(.system(.body, design: .serif))
                .fontWeight(.regular)
            
        }
        .padding()
    }
}

struct UserRepositoryBranchListView_Previews: PreviewProvider {
    static var previews: some View {
        UserRepositoryBranchListView(listItem: .constant([]))
    }
}
