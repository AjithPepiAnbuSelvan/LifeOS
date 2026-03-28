import SwiftUI
import SwiftData

struct FinanceView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: FinanceViewModel
    @State private var showAddTransaction = false

    init() {
        // Placeholder; real context is provided from the environment on appear.
        _viewModel = StateObject(
            wrappedValue: FinanceViewModel(
                context: ModelContext(PersistenceController.preview.container)
            )
        )
    }

    var body: some View {
        List {
            Section(header: Text("Today")) {
                ForEach(todayTransactions) { transactionRow($0) }
                    .onDelete { offsets in delete(from: todayTransactions, offsets: offsets) }
            }

            if !yesterdayTransactions.isEmpty {
                Section(header: Text("Yesterday")) {
                    ForEach(yesterdayTransactions) { transactionRow($0) }
                        .onDelete { offsets in delete(from: yesterdayTransactions, offsets: offsets) }
                }
            }

            if !olderTransactions.isEmpty {
                Section(header: Text("Older")) {
                    ForEach(olderTransactions) { transactionRow($0) }
                        .onDelete { offsets in delete(from: olderTransactions, offsets: offsets) }
                }
            }
        }
        .navigationTitle("Finance")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddTransaction = true
                } label: {
				 Image(systemName: "plus")
					 .imageScale(.large)
					 .padding(.horizontal, 4)
                }
            }
        }
        .onAppear { viewModel.updateContext(modelContext) }
        .sheet(isPresented: $showAddTransaction) {
            AddTransactionView(viewModel: viewModel)
        }
    }

    private var todayTransactions: [Transaction] {
        groupedTransactions[.today] ?? []
    }

    private var yesterdayTransactions: [Transaction] {
        groupedTransactions[.yesterday] ?? []
    }

    private var olderTransactions: [Transaction] {
        groupedTransactions[.older] ?? []
    }

    private enum TransactionSection {
        case today, yesterday, older
    }

    private var groupedTransactions: [TransactionSection: [Transaction]] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!

        return viewModel.transactions.reduce(into: [:]) { result, transaction in
            let transactionDay = calendar.startOfDay(for: transaction.date)
            let section: TransactionSection

            if transactionDay == today {
                section = .today
            } else if transactionDay == yesterday {
                section = .yesterday
            } else {
                section = .older
            }

            result[section, default: []].append(transaction)
        }
    }

    @ViewBuilder
    private func transactionRow(_ transaction: Transaction) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.category)
                    .font(.headline)
                if let note = transaction.notes, !note.isEmpty {
                    Text(note)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            Text(formattedAmount(for: transaction))
                .foregroundStyle(transaction.isExpense ? .red : .green)
        }
        .padding(.vertical, 4)
    }

    private func delete(from source: [Transaction], offsets: IndexSet) {
        for index in offsets {
            let transaction = source[index]
            viewModel.deleteTransaction(transaction)
        }
    }

    private func formattedAmount(for transaction: Transaction) -> String {
        let sign = transaction.isExpense ? "-" : "+"
        let number = NSDecimalNumber(decimal: transaction.amount)
        return "\(sign)\(number.stringValue)"
    }
}

#Preview {
    NavigationStack {
        FinanceView()
            .modelContainer(PersistenceController.preview.container)
    }
}

