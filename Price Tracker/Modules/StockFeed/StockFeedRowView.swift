//
//  StockFeedRowView.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import SwiftUI

struct StockFeedRowView: View, PriceDirectionRepresentable {
  var direction: PriceDirection {
    row.direction
  }
  let row: StockFeedRow
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(row.symbol)
          .font(.headline)
        Text(row.company)
          .font(.subheadline)
      }
      
      Spacer()
      
      Text("\(row.price, specifier: "%.2f")")
        .font(.subheadline)
      Text(directionSymbol)
        .font(.subheadline.bold())
        .foregroundStyle(directionColor)
   
    }
  }
}
