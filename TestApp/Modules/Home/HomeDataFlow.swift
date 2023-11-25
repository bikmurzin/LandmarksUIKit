import Foundation

enum HomeDataFlow {
    enum PresentItems {
        struct Response {
            let items: [HomeItemModel]
        }
    }
    
    enum ViewState {
        case displayItems(items: [HomeItemModel])
    }
}
