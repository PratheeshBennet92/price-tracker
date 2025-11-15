//
//  StockFeedDetailView.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 15/11/25.
//

import SwiftUI

struct StockFeedDetailView: View, PriceDirectionRepresentable, ConnectionSignalRepresentable {
  var connectionState: WebSocketConnectionState {
    viewModel.connectionState
  }
  
  var direction: PriceDirection {
    viewModel.stockFeedRow.direction
  }
  
  @StateObject var viewModel: StockFeedDetailViewModel
  init(viewModel: StockFeedDetailViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    NavigationStack {
      LazyVStack {
        Text(viewModel.stockFeedRow.company)
          .font(Font.title).padding(.bottom, 20)
        HStack {
          StockPriceLabel(row: viewModel.stockFeedRow)
            .font(.title2.bold())
          Text(directionSymbol)
            .font(.title2.bold())
            .foregroundStyle(directionColor)
        }
      }
    }.navigationTitle(Text("\(viewModel.stockFeedRow.symbol)"))
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          errorView
          connectionStatusSignalView
        }
      }
  }
}
