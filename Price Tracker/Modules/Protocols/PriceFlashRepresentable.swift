//
//  PriceFlashRepresentable.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 15/11/25.
//

import SwiftUI

protocol PriceFlashRepresentable {
  var direction: PriceDirection { get }
}

extension PriceFlashRepresentable {
  var priceTextColor: Color {
    switch direction {
    case .up:   return .green
    case .down: return .red
    default:
      return .primary
    }
  }
}
