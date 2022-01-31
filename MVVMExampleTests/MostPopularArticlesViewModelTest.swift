//
//  MostPopularArticlesViewModelTest.swift
//  MVVMExampleTests
//
//  Created by Mac on 1/31/22.
//

import XCTest

@testable import MVVMExample

class MostPopularArticlesViewModelTest: XCTestCase {

    var sut:MostPopularArticlesViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut=MostPopularArticlesViewModel()

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut=nil

    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetArticlesData()
    {
        let sut = self.sut!

        let expect = XCTestExpectation(description: "callback")
        var responseSucess:[Result]?

        sut.getArticlesData()
        sut.articleModelObservable.subscribe(onNext: { result in
            responseSucess=result
            expect.fulfill()
        })
        wait(for: [expect], timeout:3)
        
        XCTAssertNotNil(responseSucess)
    }

}
