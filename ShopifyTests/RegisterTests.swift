//
//  RegisterTests.swift
//  ShopifyTests
//
//  Created by Nasr on 21/03/2022.
//

import XCTest
@testable import Shopify

class RegisterTests: XCTestCase {

    let networking = Networking()
    let registerViewModel = RegisterViewModel()
    
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
    
    func testRegisterNetworking(){
        let myExpectation = expectation(description: "wating for register networking api response")
        
        let customer = Customer(first_name: "Ahmed", last_name: "Nasr", email: "ahmednasr8898@gmail.com", phone: "09876543", tags: "123456", id: nil, verified_email: true, addresses: nil)
        let newCustomer = NewCustomer(customer: customer)
        
        networking.register(newCustomer: newCustomer) { data, response, error in
            if error != nil{
                XCTFail()
            }else{
                XCTAssertNotNil(data)
                myExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 6, handler: nil)
    }
    
    func testCreateNewCustomer(){
        let myExpectation = expectation(description: "wating for create new customer api response")
        
        let customer = Customer(first_name: "Ahmed", last_name: "Nasr", email: "ahmednasr8898@gmail.com", phone: "09876543", tags: "123456", id: nil, verified_email: true, addresses: nil)
        let newCustomer = NewCustomer(customer: customer)
        
        registerViewModel.createNewCustomer(newCustomer: newCustomer) { data, response, error in
            if error != nil{
                XCTFail()
            }else{
                XCTAssertNotNil(data)
                myExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 6, handler: nil)
    }
    
    func testCheckUserIsExist(){
        let myExpectation = expectation(description: "wating for register api response")
         registerViewModel.checkUserIsExist(email: "nasrahmed@gmail.com") { userIsExist in
            if userIsExist{
                myExpectation.fulfill()
            }else{
                XCTFail()
            }
        }
        waitForExpectations(timeout: 6, handler: nil)
    }
}
