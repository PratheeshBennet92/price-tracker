//
//  Price_TrackerTests.swift
//  Price TrackerTests
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import XCTest
@testable import Price_Tracker

@MainActor
final class Price_TrackerTests: XCTestCase {
  
  func testSocketSendAndReceive()  throws {
    let handler = WebSocketHandler<StockPriceFeed>()
    handler.connect()
    let feed = StockPriceFeed(symbol: "AAPL", name: "Apple", price: 150.0, timestamp: .now)
    handler.sendMessage(feed)
    handler.receiveMessages()
    let viewModel = StockFeedViewModel(socketHandler: handler)
    viewModel.startPolling()
    viewModel.startUIListening()
    let expectation = XCTestExpectation(description: "wait for combine update")
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 5.0)
    XCTAssertEqual(viewModel.stocks.count, 1)
    XCTAssertEqual(viewModel.stocks.first?.symbol, "AAPL")
  }
  
  func testSortingByPrice()  throws {
    let handler = WebSocketHandler<StockPriceFeed>()
    handler.connect()
    let feed = [
      StockPriceFeed(symbol: "AAPL", name: "Apple", price: 1150.0, timestamp: .now),
      StockPriceFeed(symbol: "GOOLE", name: "Google", price: 550.0, timestamp: .now),
      StockPriceFeed(symbol: "BBC", name: "BBC", price: 350.0, timestamp: .now)]
    feed.forEach { handler.sendMessage($0) }
    handler.receiveMessages()
    let viewModel = StockFeedViewModel(socketHandler: handler)
    viewModel.startPolling()
    viewModel.startUIListening()
    let expectation = XCTestExpectation(description: "wait for combine update")
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 5.0)
    XCTAssertEqual(viewModel.stocks.first?.price, 1150.0)
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
  
  
}
