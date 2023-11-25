import Foundation

protocol DetailsBusinessLogic: AnyObject {
    func initialLoad()
}

final class DetailsInteractor: DetailsBusinessLogic {
    
    let presenter: DetailsPresentationLogic
    let config: DetailsBuilder.Config
    
    init(
        presenter: DetailsPresentationLogic,
        config: DetailsBuilder.Config
    ) {
        self.presenter = presenter
        self.config = config
    }
    
    func initialLoad() {
        presenter.present(response: .init(item: config.item))
    }
}
