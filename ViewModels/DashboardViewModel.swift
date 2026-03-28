import Foundation
import Combine
import SwiftData

@MainActor
final class DashboardViewModel: ObservableObject {
    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func updateContext(_ context: ModelContext) {
        self.context = context
    }

    // MARK: - Public computed properties

    var totalBalance: Decimal {
        let transactions = fetchTransactions()
        return transactions.reduce(0) { partial, transaction in
            let signedAmount = transaction.isExpense ? -transaction.amount : transaction.amount
            return partial + signedAmount
        }
    }

    var monthlyExpenses: Decimal {
        let transactions = fetchTransactions()
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: Date()) else {
            return 0
        }

        return transactions.reduce(0) { partial, transaction in
            guard transaction.isExpense,
                  monthInterval.contains(transaction.date) else {
                return partial
            }
            return partial + transaction.amount
        }
    }

    var activeSubscriptionsCount: Int {
        fetchActiveSubscriptions().count
    }

    var upcomingMaintenanceCount: Int {
        let now = Date()
        return fetchMaintenanceItems().filter { item in
            guard let nextDueAt = item.nextDueAt else { return false }
            return nextDueAt >= now
        }.count
    }

    var expiringDocumentsCount: Int {
        let now = Date()
        guard let windowEnd = Calendar.current.date(byAdding: .day, value: 30, to: now) else {
            return 0
        }

        return fetchDocumentItems().filter { document in
            guard let expiresAt = document.expiresAt else { return false }
            return (now ... windowEnd).contains(expiresAt)
        }.count
    }

    // MARK: - Fetch helpers

    private func fetchTransactions() -> [Transaction] {
        let descriptor = FetchDescriptor<Transaction>()
        return (try? context.fetch(descriptor)) ?? []
    }

    private func fetchActiveSubscriptions() -> [Subscription] {
        var descriptor = FetchDescriptor<Subscription>()
        descriptor.predicate = #Predicate { $0.isActive == true }
        return (try? context.fetch(descriptor)) ?? []
    }

    private func fetchMaintenanceItems() -> [MaintenanceItem] {
        let descriptor = FetchDescriptor<MaintenanceItem>()
        return (try? context.fetch(descriptor)) ?? []
    }

    private func fetchDocumentItems() -> [DocumentItem] {
        let descriptor = FetchDescriptor<DocumentItem>()
        return (try? context.fetch(descriptor)) ?? []
    }
}

