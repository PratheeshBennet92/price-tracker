//
//  StockFeedView.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 14/11/25.
//

import SwiftUI


struct StockFeedView: View {
  @StateObject private var viewModel: StockFeedViewModel
  @State private var isPolling: Bool = false
  @State private var shouldShowErrorAlert: Bool = false

  init(socketHandler: WebSocketHandler<StockPriceFeed>) {
    _viewModel = StateObject(wrappedValue: StockFeedViewModel(socketHandler: socketHandler))
  }
  private var errorView: some View {
    Group {
      if case .failed(let error) = viewModel.connectionState {
        Text(error.description ?? "Unknown WebSocket error")
          .foregroundColor(.red)
          .padding(.horizontal, 16)
      } else {
        EmptyView()
      }
    }
  }
  private var connectionStatus: some View {
    HStack {
      if case .failed = viewModel.connectionState {
        EmptyView()
      } else {
        Text("\(isPolling ? "🟢" : "🔴") \(viewModel.connectionState.connectionState)")
          .font(.headline)
      }
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
          Text("\(row.symbol) - \(row.price)")
        } label: {
          StockFeedRowView(row: row)
        }
      }
      .navigationTitle("Stocks")
      .toolbar {
        ToolbarItem(placement: .automatic) {
          
        }
      }
      
      .onAppear {
        viewModel.startPolling()
        isPolling = true
      }
    }
  }
}

