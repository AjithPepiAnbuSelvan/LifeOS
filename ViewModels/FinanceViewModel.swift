import Foundation
import Combine
import SwiftData

@MainActor
final class FinanceViewModel: ObservableObject {
    @Published private(set) var transactions: [Transaction] = []

    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
        reloadTransactions()
    }

    func updateContext(_ context: ModelContext) {
        self.context = context
        reloadTransactions()
    }

    // MARK: - Public API

    func reloadTransactions() {
        let sort = SortDescriptor(\Transaction.date, order: .reverse)
        let descriptor = FetchDescriptor<Transaction>(sortBy: [sort])
        transactions = (try? context.fetch(descriptor)) ?? []
    }

    func addTransaction(
        title: String,
        amount: Decimal,
        type: TransactionType = .expense,
        category: String,
        account: String? = nil,
        date: Date = Date(),
        notes: String? = nil,
        isRecurring: Bool = false
    ) {
        let isExpense = (type != .income)

        let transaction = Transaction(
            title: title,
            notes: notes,
            amount: amount,
            type: type,
            isExpense: isExpense,
            category: category,
            account: account,
            date: date,
            isRecurring: isRecurring
        )

        context.insert(transaction)
        reloadTransactions()
    }

    func deleteTransaction(_ transaction: Transaction) {
        context.delete(transaction)
        reloadTransactions()
    }

    var totalBalance: Decimal {
        transactions.reduce(0) { partial, transaction in
            let signedAmount = transaction.isExpense ? -transaction.amount : transaction.amount
            return partial + signedAmount
        }
    }
}

