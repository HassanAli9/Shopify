//
//  NetworkingTests.swift
//  ShopifyTests
//
//  Created by Nasr on 21/03/2022.
//

import XCTest
@testable import Shopify

class NetworkingTests: XCTestCase {

    let networking = Networking()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetAllBrands(){
        let myExpectation = expectation(description: "wating for brands api response")
        networking.getAllBrands { brands, error in
            if error != nil {
                XCTFail()
            }else{
                XCTAssertNotNil(brands)
                //XCTAssertEqual(brands?.smart_collections?.count, 3, "errordc")
                myExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 6, handler: nil)
    }
    
    func testGetAllProductsInCategory(){
        let myExpectation = expectation(description: "wating for products in category api response")
        networking.getAllProductsInCategory(complition: { products, error in
            if error != nil{
                XCTFail()
            }else{
                XCTAssertNotNil(products)
                //XCTAssertEqual(products?.products?.count, 100, "errordc")
                myExpectation.fulfill()
            }
        }, collectionID: 272069034031)
        waitForExpectations(timeout: 6, handler: nil)
    }
}
