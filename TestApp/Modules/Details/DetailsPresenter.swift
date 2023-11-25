import UIKit

protocol DetailsPresentationLogic: AnyObject {
    func present(response: DetailsDataFlow.PresentItem.Response)
}

final class DetailsPresenter: DetailsPresentationLogic {
    
    weak var viewController: DetailsDisplayLogic?
    
    func present(response: DetailsDataFlow.PresentItem.Response) {
        viewController?.display(.displayItem(items: response.item))
    }
}
