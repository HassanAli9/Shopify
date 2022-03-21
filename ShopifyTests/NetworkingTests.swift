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
    
    func testGetAllCustomers(){
        let customerExpectation = expectation(description: "Waiting for API response")
        networking.getAllCustomers { customers, error in
            if let error = error {
                XCTFail()
                print(error.localizedDescription)
            }else{
                XCTAssertNotNil(customers)
                customerExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetAllProducts(){
        let productExpectation = expectation(description: "Waiting for API response")
        networking.getAllProducts { products, error in
            if let error = error {
                XCTFail()
                print(error.localizedDescription)
            }else{
                XCTAssertNotNil(products)
                productExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
