import Foundation

enum DetailsDataFlow {
    enum PresentItem {
        struct Response {
            let item: HomeItemModel
        }
    }
    
    enum ViewState {
        case displayItem(items: HomeItemModel)
    }
}
