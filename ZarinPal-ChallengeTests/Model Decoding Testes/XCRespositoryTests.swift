//
//  XCRespositoryTests.swift
//  ZarinPal-ChallengeTests
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import Foundation
import XCTest
@testable import ZarinPal_Challenge

class XCRespositoryTests: XCTestCase {

    let response = gitResponse
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGraphQLResponse() {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let data = response.data(using: .utf8, allowLossyConversion: false)!
        
        do {
            
            let object = try decoder.decode(GraphQLResponse<Repositories>.self, from: data)
            
            XCTAssertTrue(object is GraphQLResponse<Repositories>, "failing to decoding object")
            
            print(object.data?.repositores.compactMap { $0.name })
            print(object.data?.page)
            
        }catch let error {
            XCTAssertNil(error, "error in decoding \(error)")
        }
        
    }


}

private let gitResponse = """
{
  "data": {
    "viewer": {
      "repositories": {
        "totalCount": 35,
        "edges": [
          {
            "node": {
              "id": "MDEwOlJlcG9zaXRvcnkyNzE2NzA2NDI=",
              "name": "communere-challenge",
              "description": "Communere Mobile Test Challenge Code.",
              "forkCount": 0,
              "stargazers": {
                "totalCount": 0
              },
              "owner": {
                "avatarUrl": "https://avatars2.githubusercontent.com/u/8974683?u=44f621f5c035be592d01d6a0bbf9deb42f3a01ca&v=4"
              },
              "primaryLanguage": null
            }
          },
          {
            "node": {
              "id": "MDEwOlJlcG9zaXRvcnkyNzE3MTExNjU=",
              "name": "iOS-Clean-Architecture-MVVM",
              "description": "Sample iOS application using Clean Architecture and MVVM",
              "forkCount": 0,
              "stargazers": {
                "totalCount": 0
              },
              "owner": {
                "avatarUrl": "https://avatars2.githubusercontent.com/u/8974683?u=44f621f5c035be592d01d6a0bbf9deb42f3a01ca&v=4"
              },
              "primaryLanguage": {
                "name": "Swift",
                "color": "#ffac45"
              }
            }
          },
          {
            "node": {
              "id": "MDEwOlJlcG9zaXRvcnkyNzI4MTAyMDc=",
              "name": "ZarinPal-Challenge",
              "description": null,
              "forkCount": 0,
              "stargazers": {
                "totalCount": 0
              },
              "owner": {
                "avatarUrl": "https://avatars2.githubusercontent.com/u/8974683?u=44f621f5c035be592d01d6a0bbf9deb42f3a01ca&v=4"
              },
              "primaryLanguage": null
            }
          }
        ],
        "pageInfo": {
          "endCursor": "Y3Vyc29yOnYyOpHOEELA3w==",
          "hasNextPage": false,
          "hasPreviousPage": true
        }
      }
    }
  }
}
"""
