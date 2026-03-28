import Foundation
import SwiftData

@Model
final class InventoryItem {
    @Attribute(.unique) var id: UUID
    var createdAt: Date

    var name: String
    var category: String

    var quantity: Int
    var unit: String          // e.g. "pcs", "kg"

    var location: String?     // e.g. "Home office", "Garage"
    var purchaseDate: Date?
    var expiryDate: Date?

    var valuePerUnit: Decimal
    var notes: String?

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        name: String,
        category: String,
        quantity: Int = 1,
        unit: String = "pcs",
        location: String? = nil,
        purchaseDate: Date? = nil,
        expiryDate: Date? = nil,
        valuePerUnit: Decimal = 0,
        notes: String? = nil
    ) {
        self.id = id
        self.createdAt = createdAt
        self.name = name
        self.category = category
        self.quantity = quantity
        self.unit = unit
        self.location = location
        self.purchaseDate = purchaseDate
        self.expiryDate = expiryDate
        self.valuePerUnit = valuePerUnit
        self.notes = notes
    }
}
