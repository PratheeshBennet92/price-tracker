//
//  Price_TrackerApp.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import SwiftUI

@main
struct Price_TrackerApp: App {
  let mockFeedManager = MockPriceFeedManager.shared
  var body: some Scene {
    WindowGroup {
      StockFeedView()
    }
  }
}
