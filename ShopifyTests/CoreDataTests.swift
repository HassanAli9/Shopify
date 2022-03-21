//
//  CoreDataTests.swift
//  ShopifyTests
//
//  Created by Nasr on 21/03/2022.
//

import XCTest
@testable import Shopify

class CoreDataTests: XCTestCase {
    
    let coreDataServices = CoreDataServices()

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

    func testGetAllWishListProduct(){
        let myExpectation = expectation(description: "wating for get wishList product response")
        coreDataServices.getAllWishListProduct { wishList, error in
            if error != nil{
                XCTFail()
            }else{
                XCTAssertNotNil(wishList)
               // XCTAssertEqual(wishList?.count, 211)
                myExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetWishListProductForSelectedCustomer(){
        let myExpectation = expectation(description: "wating for get wishList product for selected customer response")
        coreDataServices.getWishListProductForSelectedCustomer(customerID: 5755651817519) { wishList, error in
            if error != nil{
                XCTFail()
            }else{
                XCTAssertNotNil(wishList)
                //XCTAssertEqual(wishList?.count, 0)
                myExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDeletedSelectedProductFromWishList(){
        let myExpectation = expectation(description: "wating for delete wishList product for selected customer response")
        
        let wishList = WishListModel(context: context)
        wishList.productID = 2
        wishList.customerID = 2
        wishList.productName = ""
        wishList.productPrice = ""
        wishList.productImage = ""
        
        coreDataServices.deletedSelectedProductFromWishList(product: wishList) { deletedSuccess in
            if deletedSuccess{
                myExpectation.fulfill()
            }else{
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
