//
//  TimerAppInMVVMTests.swift
//  TimerAppInMVVMTests
//
//  Created by Kunal Arora on 21/12/15.
//  Copyright © 2015 Kunal Arora. All rights reserved.
//

import XCTest
@testable import TimerAppInMVVM

class TimerAppInMVVMTests: XCTestCase {
    
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
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    var startTime = 0.0
    var timer: NSTimer!
    var currentTime = 0.0
    func testTimer() {
        print("dddd")

        
    self.startTime = NSDate.timeIntervalSinceReferenceDate()
       timer = NSTimer(timeInterval: 3.0, target: self, selector: "fire", userInfo: nil, repeats: false)
        
        func fire() {
            print("dddd")
           currentTime  = NSDate.timeIntervalSinceReferenceDate()
            print("startTime:\(startTime)")
            print(currentTime)
            print("dd")
            
        }
        XCAssert
    }
    
    
    
}
