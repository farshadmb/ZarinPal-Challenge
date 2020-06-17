//
//  UserProfileView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 5.0) {
                UserProfileHeaderView()
                UserProfileDetailRowView(title: "Email", value: "farshadm90@gmail.com")
                UserProfileDetailRowView(title:"work",value:"Digipay")
                UserProfileDetailRowView(title: "website", value: "Google")
                UserProfileDetailRowView()
                UserProfileDetailRowView()
                UserProfileDetailRowView()
            }
            .padding()
        }
        .navigationBarTitle("Profile")
    }
}

struct UserProfileHeaderView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70, alignment: .topLeading)
                .foregroundColor(.green)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Farshad Mousalou")
                    .fontWeight(.medium)
                    .font(.system(.headline))
                Text("@farshadmb")
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
                })
            }
            Spacer()
        }
        .padding()
    }
    
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
