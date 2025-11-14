//
//  Price_TrackerApp.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import SwiftUI

@main
struct Price_TrackerApp: App {
  private let socketHandler = WebSocketHandler<StockPriceFeed>()
  let mockFeedManager: MockPriceFeedManager
  
  init() {
    mockFeedManager = MockPriceFeedManager(socketHandler: socketHandler)
  }
  
  var body: some Scene {
    WindowGroup {
      StockFeedContainer().environment(\.stockPriceSocketHandler, socketHandler)
    }
  }
}

private struct StockPriceSocketHandlerKey: EnvironmentKey {
  static let defaultValue: WebSocketHandler<StockPriceFeed> = WebSocketHandler<StockPriceFeed>()
}

extension EnvironmentValues {
  var stockPriceSocketHandler: WebSocketHandler<StockPriceFeed> {
    get { self[StockPriceSocketHandlerKey.self] }
    set { self[StockPriceSocketHandlerKey.self] = newValue }
  }
}
