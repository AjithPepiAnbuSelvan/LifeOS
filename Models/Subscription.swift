import Foundation
import SwiftData

@Model
final class Subscription {
    @Attribute(.unique) var id: UUID
    var createdAt: Date

    var name: String
    var service: String

    var amount: Decimal
    var currencyCode: String

    var billingCycle: String      // e.g. "monthly", "yearly"
    var nextBillingDate: Date
    var isActive: Bool

    var category: String
    var notes: String?

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        name: String,
        service: String,
        amount: Decimal,
        currencyCode: String = "USD",
        billingCycle: String,
        nextBillingDate: Date,
        isActive: Bool = true,
        category: String,
        notes: String? = nil
    ) {
        self.id = id
        self.createdAt = createdAt
        self.name = name
        self.service = service
        self.amount = amount
        self.currencyCode = currencyCode
        self.billingCycle = billingCycle
        self.nextBillingDate = nextBillingDate
        self.isActive = isActive
        self.category = category
        self.notes = notes
    }
}
