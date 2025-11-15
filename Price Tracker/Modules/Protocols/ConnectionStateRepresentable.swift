//
//  ConnectionStateRepresentable.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 15/11/25.
//

import SwiftUI

protocol ConnectionSignalRepresentable {
  var connectionState: WebSocketConnectionState { get }
}
extension ConnectionSignalRepresentable {
  var statusSignal: String {
    switch connectionState {
    case .connected:
      return "🟢"
    case .disconnected:
      return "🔴"
    default:
      return ""
    }
  }
  
  @ViewBuilder
  var connectionStatusSignalView: some View {
    if case .failed = connectionState {
      EmptyView()
    } else {
      Text("\(statusSignal) \(connectionState.state)")
        .font(.headline).padding(10)
    }
  }
  
  @ViewBuilder
  var errorView: some View {
    if case .failed(let error) = connectionState {
      Text(error.description ?? "Unknown WebSocket error")
        .foregroundColor(.red)
        .padding(.horizontal, 16)
    } else {
      EmptyView()
    }
  }
}

