# Price-Tracker



https://github.com/user-attachments/assets/2aea69d1-274c-4702-812f-70e10a420983



## Architecture

The project follows a strict MVVM and unidirectional data flow structure using Combine.

The design is intentionally independent and modular:
- The WebSocket handler  WebSocketHandler<T: Codable> is generic and reusable across any data type.
- ViewModels contain all network stream subscribers, data streams, business logic, including sorting, price-direction calculation, state handling, and data transformation. Views never perform logic.
- Views contain only UI rendering, subscribing to `@Published` properties and data streams from the ViewModel. All formatting, animations, and display behaviors remain UI-focused, keeping a strict separation from application logic.
- UI components rely on lightweight protocols such as `PriceDirectionRepresentable`, `PriceFlashRepresentable`, and `ConnectionSignalRepresentable` to handle price directional indicators, price-flash behavior, and connection state.  
- These protocol-driven components. logics are fully reusable and plug-and-play across multiple views without duplicating logic, promoting clean separation of concerns and consistency in UI behavior. E.g., sharing common UI components and logic between StockFeedDetailView & StockFeedView


---

## WebSocketHandler

- Generic class responsible for WebSocket communication  
- Connects to: `wss://ws.postman-echo.com/raw`  
- Sends messages  
- Receives echoed responses  


---

## MockPriceFeedManager

- Generates mock stock price updates at regular intervals  

---

## ViewModels

### StockFeedViewModel
- Manages stock list updates  
- Tracks WebSocket connection state  

### StockFeedDetailViewModel
- Listens only for updates related to the selected stock  

---

## Views

### StockFeedView
- Displays the main list of live prices  

### StockFeedDetailView
- Detail screen showing price movements for the selected stock  

---

## Reusable Components

- UI components rely on lightweight protocols such as `PriceDirectionRepresentable`, `PriceFlashRepresentable`, and `ConnectionSignalRepresentable` to handle price directional indicators, price-flash behavior, and connection state.  
- These protocol-driven components. logics are fully reusable and plug-and-play across multiple views without duplicating logic, promoting clean separation of concerns and consistency in UI behavior. E.g., sharing common UI components and logic between StockFeedDetailView & StockFeedView

