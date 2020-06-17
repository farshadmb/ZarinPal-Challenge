//
//  RepositoryData.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import SwiftUI

struct RepositoryData: Identifiable {
    
    var id: String {
        return title
    }
    
    var title: String
    var description: String?
    
    var branches: [BranchData] = []
    var pullRequests: [PullRequestData] = []
    var issues: [IssueData] = []
}

extension RepositoryData {
    
    struct PullRequestData : Identifiable {
        
        var id : String {
            return number
        }
        
        var number: String
        var title: String
        var date: Date
        var description: String
        
    }
    
    struct BranchData: Identifiable {
        
        var id: String {
            return title
        }
        
        var title: String
        var createdDate: Date
        var updateDate: Date
    }
    
    struct IssueData: Identifiable {
           
           var id: String {
               return number
           }
           
        var number: String
        var title: String
        var date: Date
        var description: String
       }
    
}
