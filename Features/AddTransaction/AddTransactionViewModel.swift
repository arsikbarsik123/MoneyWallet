import SwiftUI

final class AddTransactionViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var amount: String = ""
    @Published var type: TransactionType = .expense
    
    var isSaveEnable: Bool {
        guard
            !title.isEmpty,
            let value = Double(amount),
            value > 0
        else {
            return false
        }
        
        return true
    }
    
    func makeTransaction() -> Transaction {
        Transaction(
            id: UUID(),
            title: title,
            amount: Double(amount) ?? 0,
            date: .now,
            type: type
        )
    }
}
