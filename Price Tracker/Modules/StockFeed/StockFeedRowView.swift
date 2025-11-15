//
//  StockFeedRowView.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import SwiftUI

struct StockFeedRowView: View {
  let row: StockFeedRow
  private var directionSymbol: String {
    switch row.direction {
    case .up:   return "↑"
    case .down: return "↓"
    default:
      return ""
    }
  }
  private var directionColor: Color {
    switch row.direction {
    case .up:   return .green
    case .down: return .red
    default:
      return .white
    }
  }
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
