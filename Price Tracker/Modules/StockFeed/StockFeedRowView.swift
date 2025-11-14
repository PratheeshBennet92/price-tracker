//
//  StockFeedRowView.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import SwiftUI

struct StockFeedRowView: View {
  let row: StockFeedRow
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(row.symbol)
          .font(.headline)
        Text("\(row.price, specifier: "%.2f")")
          .font(.subheadline)
      }
      Spacer()
    }
  }
}
