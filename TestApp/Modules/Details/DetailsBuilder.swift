import UIKit

extension DetailsBuilder {
    struct Config {
        let item: HomeItemModel
    }
}

public final class DetailsBuilder: ModuleBuilder {
    private let config: Config
    
    init(config: Config) {
        self.config = config
    }
    
    func build() -> UIViewController {
        let presenter = DetailsPresenter()
        let interactor = DetailsInteractor(presenter: presenter, config: config)
        let controller = DetailsViewController(interactor: interactor, config: config)
        presenter.viewController = controller

        return controller
    }
}
