//
//  StockPriceLabel.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 15/11/25.
//

import SwiftUI
import Combine

struct StockPriceLabel: View, PriceFlashRepresentable {
  var direction: PriceDirection {
    row.direction
  }
  @State private var textColor: Color = .primary
  @State private var lastPrice: Double = 0
  let row: StockFeedRow
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  var body: some View {
    Text("\(row.price, specifier: "%.2f")")
      .foregroundStyle(textColor)
      .onReceive(timer) { _ in
        withAnimation(.easeOut(duration: 0.25)) {
          textColor = .primary
        }
      }
      .onReceive(Just(row.price)) { newPrice in
        withAnimation(.easeOut(duration: 0.25)) {
          let difference = Date.now.timeIntervalSince(row.timestamp)
          if newPrice != lastPrice && difference < 2 {
            withAnimation(.easeOut(duration: 0.25)) {
              textColor = priceTextColor
            }
            lastPrice = newPrice
          }
        }
      }
  }
}
