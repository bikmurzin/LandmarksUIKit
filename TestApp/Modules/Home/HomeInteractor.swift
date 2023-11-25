import Foundation

protocol HomeBusinessLogic: AnyObject {
    func initialLoad()
}

final class HomeInteractor: HomeBusinessLogic {
    
    let presenter: HomePresentationLogic
    let provider: HomeProviderProtocol
    
    init(
        presenter: HomePresentationLogic,
        provider: HomeProviderProtocol = HomeProvider()
    ) {
        self.presenter = presenter
        self.provider = provider
    }
    
    func initialLoad() {
        let items = provider.fetchItems()
        presenter.present(response: .init(items: items))
    }
}
