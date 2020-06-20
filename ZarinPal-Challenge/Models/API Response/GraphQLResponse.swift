//
//  GraphQLResponse.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import JSONValueRX

struct GraphQLResponse <T: Decodable>: Decodable {
    
    let data: T?
    let errors: [JSONValue]?
    
    enum RootCodingKey : String, CodingKey {
        case data
        case errors
    }
    
    enum ViewerCodingKey : String, CodingKey {
        case viewer
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKey.self)
        let wrapperContainer = try container.nestedContainer(keyedBy: ViewerCodingKey.self, forKey: .data)
        data = try wrapperContainer.decode(T.self, forKey: .viewer)
        errors = try container.decodeIfPresent([JSONValue].self, forKey: .errors)
    }
    
    
}
