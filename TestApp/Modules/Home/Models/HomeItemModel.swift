import Foundation

public struct HomeItemModel: Decodable {
    let name: String
    let category: String
    let city: String
    let state: String
    let id: Int64
    let park: String
    let imageName: String
    let isFavorite: Bool
    let coordinates: Coordinates
}

struct Coordinates: Decodable {
    let longitude: Double
    let latitude: Double
}
