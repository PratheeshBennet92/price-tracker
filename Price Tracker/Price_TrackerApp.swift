//
//  Price_TrackerApp.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import SwiftUI

@main
struct Price_TrackerApp: App {
  @Environment(\.scenePhase) private var scenePhase
  @State private var shouldResumeSocket: Bool = false
  private let socketHandler = WebSocketHandler<StockPriceFeed>()
  let mockFeedManager: MockPriceFeedManager
  
  init() {
    socketHandler.connect()
    mockFeedManager = MockPriceFeedManager(socketHandler: socketHandler)
  }
  
  var body: some Scene {
    WindowGroup {
      StockFeedContainer().environment(\.stockPriceSocketHandler, socketHandler)
    }
    .onChange(of: scenePhase) { oldPhase, newPhase in
      switch (oldPhase, newPhase) {
      case (.inactive, .active):
        if shouldResumeSocket {
          socketHandler.connect()
          socketHandler.receiveMessages()
        }
      case (.active, .inactive):
        if socketHandler.connectionState == .connected {
          socketHandler.disconnect()
          shouldResumeSocket = true
        } else {
          shouldResumeSocket = false
        }
      default:
        break
      }
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
