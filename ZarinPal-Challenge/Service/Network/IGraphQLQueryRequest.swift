//
//  IGraphQLQueryRequest.swift
//  ZarinPal-Challenge
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation

/// Abstract `IGraphQLQueryRequest`
protocol IGraphQLQueryRequest {
    
    /// the graphql query string which send to graphql api
    var query: String { get }
}

// MARK: - Conformed `String` to `IGraphQLQueryRequest`
extension String: IGraphQLQueryRequest {
    
    var query: String {
        return self
    }
}
