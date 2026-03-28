import SwiftUI
import SwiftData

struct AddTransactionView: View {
    @ObservedObject var viewModel: FinanceViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var amountText: String = ""
    @State private var category: String = ""
    @State private var type: TransactionType = .expense
    @State private var date: Date = Date()
    @State private var note: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("0.00", text: $amountText)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 32, weight: .bold, design: .rounded))

                        Picker("Type", selection: $type) {
                            ForEach(TransactionType.allCases, id: \.self) { kind in
                                Text(kind.rawValue.capitalized)
                                    .tag(kind)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }

                Section {
                    TextField("Category", text: $category)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Note (optional)", text: $note)
                }
            }
            .navigationTitle("Add Transaction")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }

    private var canSave: Bool {
        Decimal(string: amountText) != nil && !category.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func save() {
        guard let amount = Decimal(string: amountText) else { return }

        viewModel.addTransaction(
            title: category,
            amount: amount,
            type: type,
            category: category,
            date: date,
            notes: note.isEmpty ? nil : note
        )

        dismiss()
    }
}

#Preview {
    let context = ModelContext(PersistenceController.preview.container)
    let vm = FinanceViewModel(context: context)

    return AddTransactionView(viewModel: vm)
}

