import UIKit

public final class HomeBuilder: ModuleBuilder {
    
    func build() -> UIViewController {
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter)
        let controller = HomeViewController(interactor: interactor)
        presenter.viewController = controller

        return controller
    }
}
