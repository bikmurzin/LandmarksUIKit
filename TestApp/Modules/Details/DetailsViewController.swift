import UIKit

protocol DetailsDisplayLogic: AnyObject {
    func display(_ state: DetailsDataFlow.ViewState)
}

final class DetailsViewController: UIViewController, DetailsDisplayLogic {
    private let interactor: DetailsBusinessLogic

    lazy var customView = DetailsModuleView()

    init(interactor: DetailsBusinessLogic, config: DetailsBuilder.Config) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        self.title = config.item.name
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.initialLoad()
    }
    
    func display(_ state: DetailsDataFlow.ViewState) {
        switch state {
        case .displayItem(let item):
            customView.update(item: item)
        }
    }
}
