import UIKit

protocol HomePresentationLogic: AnyObject {
    func present(response: HomeDataFlow.PresentItems.Response)
}

final class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    
    func present(response: HomeDataFlow.PresentItems.Response) {
        viewController?.display(.displayItems(items: response.items))
    }
}
