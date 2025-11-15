//
//  StockFeedDetailView.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 15/11/25.
//

import SwiftUI

struct StockFeedDetailView: View, PriceDirectionRepresentable {
  var direction: PriceDirection {
    viewModel.stockFeedRow.direction
  }
  
  @StateObject var viewModel: StockFeedDetailViewModel
  init(viewModel: StockFeedDetailViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    NavigationStack {
      VStack {
        Text(viewModel.stockFeedRow.company)
          .font(Font.largeTitle)
        HStack {
          Text("\(viewModel.stockFeedRow.price)")
            .font(.title)
          Text(directionSymbol)
            .font(.subheadline.bold())
            .foregroundStyle(directionColor)
        }
      }
    }.navigationTitle(Text("\(viewModel.stockFeedRow.symbol)"))
  }
}
