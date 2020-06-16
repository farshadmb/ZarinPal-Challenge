//
//  RepositoryData.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import SwiftUI

struct RespositoryData: Identifiable {
    
    var id: String {
        return title
    }
    
    var title: String
    var description: String?
    
}
