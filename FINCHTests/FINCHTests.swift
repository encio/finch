//
//  FINCHTests.swift
//  FINCHTests
//
//  Created by Peter Encio on 6/19/21.
//

import Foundation
import XCTest

class FINCHTests: XCTestCase {
  func test_failed_fetching(){
    let displayUseCase = DisplayStationUseCase (service: FinchMockServiceFailed())
    let expectation = self.expectation(description: "waiting to fail")

    var data1 = [BusStationModel]()
    var data2 = [TrainStationModel]()

    displayUseCase.fetchData(){
      data1 = $0
      data2 = $1
      expectation.fulfill()
    }
    XCTAssertTrue(data1.isEmpty && data2.isEmpty)
    waitForExpectations(timeout: 3.0, handler: nil)
    
  }
  
  func test_trainOnly_fetching(){
    let displayUseCase = DisplayStationUseCase (service: FinchMockTrainOnly())
    let expectation = self.expectation(description: "waiting to fail")

    var data1 = [BusStationModel]()
    var data2 = [TrainStationModel]()

    displayUseCase.fetchData(){
      data1 = $0
      data2 = $1
      expectation.fulfill()
    }
    XCTAssertTrue(data1.isEmpty && !data2.isEmpty)
    waitForExpectations(timeout: 3.0, handler: nil)
    
  }
  
  func test_busOnly_fetching(){
    let displayUseCase = DisplayStationUseCase (service: FinchMockBusOnly())
    let expectation = self.expectation(description: "waiting to fail")

    var data1 = [BusStationModel]()
    var data2 = [TrainStationModel]()

    displayUseCase.fetchData(){
      data1 = $0
      data2 = $1
      expectation.fulfill()
    }
    XCTAssertTrue(!data1.isEmpty && data2.isEmpty)
    waitForExpectations(timeout: 3.0, handler: nil)
    
  }
  
  
  
  func test_success_fetching(){
    
  }
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
