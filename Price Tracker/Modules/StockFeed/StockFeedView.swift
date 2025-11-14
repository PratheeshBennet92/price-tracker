//
//  StockFeedView.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import SwiftUI

struct StockFeedView: View {
  @StateObject private var viewModel = StockFeedViewModel()
  @State private var isPolling: Bool = false
  var body: some View {
    Text("Hello, World!")
  }
}
