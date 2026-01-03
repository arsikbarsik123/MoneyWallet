import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddTransactionViewModel()
    
    let onSave: (Transaction) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $viewModel.title)
                    
                    TextField("Amount", text: $viewModel.amount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Type", selection: $viewModel.type) {
                        Text("Expense").tag(TransactionType.expense)
                        Text("Income").tag(TransactionType.income)
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Add Transaction")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        save()
                    }
                    .disabled(!viewModel.isSaveEnable)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - save

private extension AddTransactionView {
    func save() {
        guard let value = Double(viewModel.amount), !viewModel.title.isEmpty else { return }
        
        let transaction = Transaction(
            id: UUID(),
            title: viewModel.title,
            amount: value,
            date: Date(),
            type: viewModel.type
        )
        
        onSave(transaction)
        dismiss()
    }
}
