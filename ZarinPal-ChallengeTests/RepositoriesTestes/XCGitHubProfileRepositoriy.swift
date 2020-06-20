//
//  XCGitHubProfileRepositoriy.swift
//  ZarinPal-ChallengeTests
//
//  Created by Farshad Mousalou on 6/20/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import XCTest

import XCTest
@testable import ZarinPal_Challenge
import RxSwift
import Alamofire

class XCGitHubProfileRepositoriy: XCTestCase {

    var networkSerivce: NetworkServiceInterceptable!
    var userRepository: GitHubUserProfileRepository<UserProfile>!
    var disposeBag : DisposeBag!
    let session = Session()
    
    override func setUp() {
        
        let interceptor = AuthenticatorFactory.default
                  
        session.sessionConfiguration.requestCachePolicy = .reloadIgnoringCacheData
        networkSerivce = APIClient(session:session,
                                   queue: .main,
                                   decoder: {
                                    let decoder = JSONDecoder()
                                    decoder.dateDecodingStrategy = .iso8601
                                    return decoder
        }())
        
        userRepository = GitHubUserProfileRepository(authenticator: interceptor, networkService: networkSerivce)
        disposeBag = DisposeBag()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        userRepository = nil
        networkSerivce = nil
        disposeBag = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchGitHubUserProfile() {
        let e = expectation(description: "testFetchGitHubUserProfile")
        e.expectedFulfillmentCount = 2
        
        fetchProfile()
            .subscribe { (event) in
                switch event {
                case .completed:
                    break
                case .next(let value):
                    print(value)
                case .error(let error):
                    XCTAssertNil(error, "Whoops, error \(error.localizedDescription)")
                }
                
                e.fulfill()
        }.disposed(by: disposeBag)
        
        self.wait(for: [e], timeout: 60.0)
    }
    
    func fetchProfile() -> Observable<UserProfile> {
        return userRepository
            .fetchUserProfile()
    }

}
