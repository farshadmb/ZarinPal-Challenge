//
//  UserRepositoryRowView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI

struct UserRepositoryRowView: View {
    
    var repository : RespositoryData
    var body: some View {
        
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
        .padding()
    }
}

struct UserRepositoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRepositoryRowView(repository: RespositoryData(title:"",description: nil))
    }
}
