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
    _viewModel = StateObject(wrappedValue: StockFeedViewModel(socketHandler: socketHandler))
  }

  var body: some View {
    List(viewModel.stocks) { row in
      NavigationLink {
        Text("\(row.symbol) - \(row.price)")
      } label: {
        StockFeedRowView(row: row)
      }
    }
    .onAppear {
      viewModel.startPolling()
    }
  }
}

