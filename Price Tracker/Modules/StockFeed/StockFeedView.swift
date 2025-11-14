//
//  StockFeedView.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import SwiftUI


struct StockFeedView: View {
  @StateObject private var viewModel: StockFeedViewModel
  @State private var isPolling: Bool = false

  init(socketHandler: WebSocketHandler<StockPriceFeed>) {
    self._viewModel = StateObject(wrappedValue: StockFeedViewModel(socketHandler: socketHandler))
    
  }

  var body: some View {
    Text("Hello, World!")
  }
}

