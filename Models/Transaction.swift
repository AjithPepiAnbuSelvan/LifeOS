import Foundation
import SwiftData

@Model
final class Transaction {
    @Attribute(.unique) var id: UUID
    var createdAt: Date

    var title: String
    var notes: String?

    var amount: Decimal
    var type: TransactionType
    var isExpense: Bool

    var category: String
    var account: String?

    var date: Date
    var isRecurring: Bool

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        title: String,
        notes: String? = nil,
        amount: Decimal,
        type: TransactionType = .expense,
        isExpense: Bool = true,
        category: String,
        account: String? = nil,
        date: Date = Date(),
        isRecurring: Bool = false
    ) {
        self.id = id
        self.createdAt = createdAt
        self.title = title
        self.notes = notes
        self.amount = amount
        self.type = type
        self.isExpense = isExpense
        self.category = category
        self.account = account
        self.date = date
        self.isRecurring = isRecurring
    }
}
