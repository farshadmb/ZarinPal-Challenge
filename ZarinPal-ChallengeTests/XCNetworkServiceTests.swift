//
//  XCNetworkServiceTests.swift
//  ZarinPal-ChallengeTests
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import XCTest
@testable import ZarinPal_Challenge
import RxSwift
import Alamofire


class XCNetworkServiceTests: XCTestCase {
    
    var networkSerivce: NetworkServiceInterceptable!
    var disposeBag : DisposeBag!
    let session = Session()
    
    override func setUp() {
        session.sessionConfiguration.requestCachePolicy = .reloadIgnoringCacheData
        networkSerivce = APIClient(session:session,
                                   queue: .main,
                                   decoder: {
                                    let decoder = JSONDecoder()
                                    decoder.dateDecodingStrategy = .iso8601
                                    return decoder
        }())
        
        disposeBag = DisposeBag()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        networkSerivce = nil
        disposeBag = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAlamofireRequest() {
        
        let e = self.expectation(description: "Alamofire Test case")
        
        let query = """
        {
          viewer {
            login
            id
            name
            email
            avatarUrl
            bio
            resourcePath
          }
        }
        """
        
        let parameters = ["query":query,"variables":"{}"] as [String:Any]
        let dataRequest = session.request("https://api.github.com/graphql",
                                          method: .post,
                                          parameters: parameters,
                                          encoding: JSONEncoding.default)
            .validate()
            .response { response in
                XCTAssertNil(response.error, "Whoops, error \(response.error!.localizedDescription)")
                
                XCTAssertNotNil(response, "No response")
                XCTAssertEqual(response.response?.statusCode ?? 0, 200, "Status code not 200")
                
                e.fulfill()
        }
        
        self.wait(for: [e], timeout: 60)
    }
    
    func testNetworkServiceAuthenticationInterceptor() {
        
        let interceptor = AuthenticatorFactory.default
        
        networkSerivce.addingRequest(interceptor: interceptor)
        
        let expectection = self.expectation(description: "Interceptor Test case")
        expectection.expectedFulfillmentCount = 2
        let query = """
{
  viewer {
    login
    id
    name
    email
    avatarUrl
    bio
    resourcePath
  }
}
"""
        networkSerivce.executeRequest(endpoint: "graphql" as INetworkServiceEndpoint,
                                      query: query as IGraphQLQueryRequest,
                                      headers: [:])
            .map { (value : Result<ServerResponse,Error>) -> ServerResponse in
                switch value {
                case .success(let output):
                    return output
                case .failure(let error):
                    throw error
                }
        }.subscribe { (event) in
            switch event {
            case .completed:
                break
            case .next(let value):
                print(value)
            case .error(let error):
                XCTAssertNil(error, "Whoops, error \(error.localizedDescription)")
            }
            
            expectection.fulfill()
            
        }.disposed(by: disposeBag)
        
        
        self.wait(for: [expectection], timeout: 60)
        
    }
    
}

extension String : IGraphQLQueryRequest {
    
    public var query: String {
        return self
    }
    
}

struct ServerResponse: Codable, Hashable {
    
    let data: DataClass?
    let errors: [Error]?
    
    struct DataClass: Codable, Hashable {
        let viewer: Viewer?
    }
    
    struct Viewer: Codable, Hashable {
        let login, id, name, email: String?
        let avatarUrl: String?
        let bio, resourcePath: String?
    }
    
    struct Error: Codable, Hashable {
        let type: String?
        let path: [String]?
        let message: String?
    }
    
}


