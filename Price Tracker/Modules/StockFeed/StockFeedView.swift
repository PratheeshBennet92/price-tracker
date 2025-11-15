//
//  StockFeedView.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import SwiftUI


struct StockFeedView: View, ConnectionSignalRepresentable {
  var connectionState: WebSocketConnectionState {
    viewModel.connectionState
  }
  
  @StateObject private var viewModel: StockFeedViewModel
  @State private var isPolling: Bool = true
  @State private var shouldShowErrorAlert: Bool = false
  private let socketHandler: WebSocketHandler<StockPriceFeed>

  init(socketHandler: WebSocketHandler<StockPriceFeed>) {
    _viewModel = StateObject(wrappedValue: StockFeedViewModel(socketHandler: socketHandler))
    self.socketHandler = socketHandler
  }
  
  private var connectionStatus: some View {
    HStack {
      connectionStatusSignalView
      Spacer()
      Toggle("", isOn: $isPolling)
        .toggleStyle(SwitchToggleStyle(tint: .green))
        .labelsHidden()
        .onChange(of: isPolling) { oldValue, newValue in
          newValue ? viewModel.startPolling() : viewModel.stopPolling()
        }
    }
    .padding(.horizontal, 16)
  }
  
  private var loader: some View {
    VStack {
      Spacer()
      ProgressView("Loading…")
        .progressViewStyle(.circular)
        .padding()
        .font(.headline)
      Spacer()
    }
  }

  var body: some View {
    NavigationStack {
      connectionStatus
      errorView
      if viewModel.stocks.isEmpty {
        loader
      }
      List(viewModel.stocks) { row in
        NavigationLink {
          StockFeedDetailView(viewModel:  StockFeedDetailViewModel(socketHandler: socketHandler, stockFeedRow: row))
        } label: {
          StockFeedRowView(row: row)
        }
      }
      .navigationTitle("Stocks")
      .onAppear {
        if isPolling {
          viewModel.startPolling()
        }
        viewModel.startUIListening()
      }
      .onDisappear {
        viewModel.stopUIListening()
      }
    }
  }
}

