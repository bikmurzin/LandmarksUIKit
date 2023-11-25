import UIKit

public protocol HomeTableDataSourceDelegate: AnyObject {
    func itemDidSelect(item: HomeItemModel)
}

extension HomeTableDataSource: SwitcherDelegate {
    func switchDidChanged(value: Bool) {
        showFavoriteOnly = value
        updateItemsToShow()
        tableView?.reloadData()
    }
    
    func updateItemsToShow() {
        if showFavoriteOnly {
            itemsToShow = items.filter({ $0.isFavorite })
        } else {
            itemsToShow = items
        }
    }
}

final class HomeTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    public weak var delegate: HomeTableDataSourceDelegate?
    
    private var showFavoriteOnly = false
    private var items: [HomeItemModel] = []
    private var itemsToShow: [HomeItemModel] = []
    
    private var tableView: UITableView?
    
    func connect(tableView: UITableView) {
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeItemCell.self, forCellReuseIdentifier: "HomeItemCell")
        tableView.register(HomeFavourCell.self, forCellReuseIdentifier: "HomeFavourCell")
    }
    
    func updateItems(items: [HomeItemModel]) {
        self.items = items
        updateItemsToShow()
        tableView?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return itemsToShow.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeItemCell", for: indexPath)
            guard let cell = cell as? HomeItemCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            let viewModel = itemsToShow[indexPath.row]
            cell.configure(item: viewModel)
            return cell
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeFavourCell", for: indexPath)
            guard let cell = cell as? HomeFavourCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(delegate: self)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            delegate?.itemDidSelect(item: itemsToShow[indexPath.row])
        }
    }
}
