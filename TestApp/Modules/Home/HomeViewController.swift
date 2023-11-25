import UIKit

protocol HomeDisplayLogic: AnyObject {
    func display(_ state: HomeDataFlow.ViewState)
}

final class HomeViewController: UIViewController, HomeDisplayLogic {
    private let interactor: HomeBusinessLogic

    lazy var customView = HomeMainView(frame: .zero)
    
    private let adapter = HomeTableDataSource()

    init(interactor: HomeBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        self.title = "Landmarks"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = customView
        adapter.connect(tableView: customView.tableView)
        adapter.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.initialLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func display(_ state: HomeDataFlow.ViewState) {
        switch state {
        case .displayItems(let items):
            adapter.updateItems(items: items)
        }
    }
}

extension HomeViewController: HomeTableDataSourceDelegate {
    func itemDidSelect(item: HomeItemModel) {
        let controller = DetailsBuilder(config: .init(item: item)).build()
        navigationController?.pushViewController(controller, animated: true)
    }
}
