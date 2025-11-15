//
//  PriceDirectionRepresentable.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 15/11/25.
//

import SwiftUI

protocol PriceDirectionRepresentable {
  var direction: PriceDirection { get }
}
extension PriceDirectionRepresentable {
  var directionSymbol: String {
    switch direction {
    case .up:   return "↑"
    case .down: return "↓"
    default:
      return ""
    }
  }
  
  var directionColor: Color {
    switch direction {
    case .up:   return .green
    case .down: return .red
    default:
      return .white
    }
  }
}
