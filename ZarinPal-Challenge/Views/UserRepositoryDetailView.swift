//
//  UserRepositoryDetailView.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import SwiftUI

struct UserRepositoryDetailView: View {
    
    enum ViewMode : String, CaseIterable {
        case branch = "Branch"
        case issues = "Issues"
        case pullRequest = "Pull Request"
    }
    
    @State var data: RepositoryData
    @State var mode : ViewMode = .branch
    
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 8) {
                data.description.map({
                    Text($0)
                        .font(.system(.body))
                        .fontWeight(.regular)
                        .lineLimit(5)
                })
                
                HStack(alignment: .lastTextBaseline) {
                    ForEach(ViewMode.allCases,id: \.self) { mode in
                        Group {
                            Button(action: {
                                self.mode = mode
                            }) {
                                Text(mode.rawValue)
                                    .font(.system(.headline))
                                    .fontWeight(.medium)
                                    .lineLimit(1)
                                    .foregroundColor(self.mode == mode ? .blue : .gray)
                                    .padding(8.0)
                                    .overlay(
                                        Capsule(style: .circular)
                                            .stroke(self.mode == mode ? Color.blue : Color.gray, lineWidth: 1.5)
                                    )
                                    
                            }
                            Spacer()
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            }
            .padding(.top, 16)
            .padding([.leading, .trailing], 8)
            buildListView(items:[])
        }
        .navigationBarTitle(Text(data.title), displayMode: .inline)
        
        
    }
    
    func buildListView(items : [String]) -> some View {
        var items = items
        if items.isEmpty {
            items = Array(repeating: self.mode.rawValue, count: 20)
        }
        
        switch self.mode {
        case .branch:
            return List(items, id: \.self) { item in
                Text(item)
                    .font(.system(.headline))
                    .fontWeight(.medium)
            }
        case .pullRequest:
            return List(items, id: \.self) { item in
                Text(item)
                    .font(.system(.body))
                    .fontWeight(.medium)
            }
        case .issues:
            return List(items, id: \.self) { item in
                Text(item)
                    .font(.system(.subheadline))
                    .fontWeight(.medium)
            }
        }
    }
}

#if GOOGLE
struct UserRepositoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserRepositoryDetailView(data:RespositoryData())
    }
}
#endif
