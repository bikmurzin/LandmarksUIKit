import Foundation

protocol HomeProviderProtocol: AnyObject {
    func fetchItems() -> [HomeItemModel]
}

final class HomeProvider: HomeProviderProtocol {
    func fetchItems() -> [HomeItemModel] {
        let jsonURL = Bundle.main.url(forResource: "landmarkData", withExtension: "json")!
        guard let data = try? Data(contentsOf: jsonURL, options: []), let items = try? JSONDecoder().decode([HomeItemModel].self, from: data) else {
            return []
        }
        return items
    }
}
