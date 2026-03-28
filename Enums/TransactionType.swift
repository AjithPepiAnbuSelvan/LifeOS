import Foundation

enum TransactionType: String, Codable, CaseIterable {
    case income
    case expense
    case emi
}
