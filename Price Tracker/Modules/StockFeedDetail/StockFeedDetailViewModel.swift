//
//  StockFeedDetailViewModel.swift
//  Price Tracker
//
//  Created by Pratheesh Bennet on 15/11/25.
//
import Foundation
import Combine

@MainActor
class StockFeedDetailViewModel: ObservableObject {
  @Published var stockFeedRow: StockFeedRow
  private let socketHandler: WebSocketHandler<StockPriceFeed>
  private var cancellables: Set<AnyCancellable> = []
  init(socketHandler: WebSocketHandler<StockPriceFeed>,
       stockFeedRow: StockFeedRow) {
    self.socketHandler = socketHandler
    self.stockFeedRow = stockFeedRow
    bindSocket()
  }
  
  private func bindSocket() {
    socketHandler.messages
      .receive(on: DispatchQueue.main)
      .sink { [weak self] feed in
        self?.handleIncoming(feed)
      }.store(in: &cancellables)
  }
  
  private func handleIncoming(_ feed: StockPriceFeed) {
    let currentSymbol = stockFeedRow.symbol
    if feed.symbol == currentSymbol {
      let oldPrice = stockFeedRow.price
      let newPrice = feed.price
      let direction = PriceDirection.state(oldPrice: oldPrice, newPrice: newPrice)
      let updateedFeed = StockFeedRow(symbol: feed.symbol,
                                      company: feed.name,
                                      price: feed.price,
                                      direction: direction)
      self.stockFeedRow = updateedFeed
    }
  }
}
