import Foundation
import SwiftData

final class PersistenceController {
    static let shared = PersistenceController()

    let container: ModelContainer

    init(inMemory: Bool = false) {
        let schema = Schema([
            Transaction.self,
            Subscription.self,
            InventoryItem.self,
            DocumentItem.self,
            MaintenanceItem.self
        ])

        let configuration: ModelConfiguration
        if inMemory {
            configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        } else {
            configuration = ModelConfiguration()
        }

        do {
            container = try ModelContainer(for: schema, configurations: configuration)
        } catch {
            fatalError("Failed to create ModelContainer: \\(error)")
        }
    }
}

extension PersistenceController {
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        return controller
    }()
}

