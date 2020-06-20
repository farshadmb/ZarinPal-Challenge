//
//  Pagination.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct Pagination : Decodable {
    
    let endCursor: String
    let hasNextPage: Bool
    let hasPreviousPage: Bool
}
