//
//  FoodiesTests.swift
//  FoodiesTests
//
//  Created by Chan Jing Hong on 02/09/2017.
//  Copyright © 2017 Cocoacode. All rights reserved.
//

import XCTest
@testable import Foodies

class FoodiesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    func testSavingFoods() {
        let controller = FoodsController.sharedInstance
        let burger = Food(name: "Burger", description: "Very nice burger")
        let chicken = Food(name: "Chicken", description: "Perfectly fried chicken")
        controller.saveFoods([burger, chicken])
    }

    func testRetrievingFoods() {
        let controller = FoodsController.sharedInstance
        let foods = controller.retrieveFoods()
        XCTAssert(foods.count > 0)
    }

    func testDeletingAllFoods() {
        let controller = FoodsController.sharedInstance
        controller.saveFoods([])
    }
}
