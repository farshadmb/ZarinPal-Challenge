//
//  XCAuthenticationService.swift
//  ZarinPal-ChallengeTests
//
//  Created by Farshad Mousalou on 6/17/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import XCTest
@testable import ZarinPal_Challenge
import RxSwift

class XCAuthenticationService: XCTestCase {

    var authentication: Authentication!
    var disposeBag : DisposeBag!
    override func setUp() {
        authentication = AuthenticationService()
        disposeBag = DisposeBag()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        authentication = nil
        disposeBag = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetCodeFromGitHub() {
        let expectation = self.expectation(description: "Getting Code Response")
        authentication.requestClientAuthorize(credential: AppConfig.clientCredetianl)
            .subscribe(onNext: { (result) in
                expectation.fulfill()
            },
                       onError: { (error) in
                        print(error)
            }).disposed(by: disposeBag)
        
        self.wait(for: [expectation], timeout: 60.0)
        
        
    }

}
