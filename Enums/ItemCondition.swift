import Foundation

enum ItemCondition: String, Codable, CaseIterable {
    case new
    case good
    case repair
    case damaged
}
