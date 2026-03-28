import Foundation
import SwiftData

@Model
final class MaintenanceItem {
    @Attribute(.unique) var id: UUID
    var createdAt: Date

    var title: String
    var area: String          // e.g. "Home", "Car", "Health"

    var notes: String?

    var frequency: String     // e.g. "monthly", "yearly", "once"
    var lastCompletedAt: Date?
    var nextDueAt: Date?

    var estimatedCost: Decimal
    var isCompleted: Bool

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        title: String,
        area: String,
        notes: String? = nil,
        frequency: String,
        lastCompletedAt: Date? = nil,
        nextDueAt: Date? = nil,
        estimatedCost: Decimal = 0,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.createdAt = createdAt
        self.title = title
        self.area = area
        self.notes = notes
        self.frequency = frequency
        self.lastCompletedAt = lastCompletedAt
        self.nextDueAt = nextDueAt
        self.estimatedCost = estimatedCost
        self.isCompleted = isCompleted
    }
}
