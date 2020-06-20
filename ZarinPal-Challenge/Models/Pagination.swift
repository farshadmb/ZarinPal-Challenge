//
//  Pagination.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

struct Pagination : Decodable {
    
    let startCursor: String?
    let hasNextPage: Bool
    let hasPreviousPage: Bool
}
