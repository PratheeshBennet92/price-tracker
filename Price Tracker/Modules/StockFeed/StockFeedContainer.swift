//
//  StockFeedContainer.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import SwiftUI

struct StockFeedContainer: View {
  @Environment(\.stockPriceSocketHandler) private var socketHandler

  var body: some View {
    StockFeedView(
      socketHandler: socketHandler
    )
  }
}
