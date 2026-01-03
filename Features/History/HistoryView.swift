import SwiftUI

struct HistoryView: View {
    let transactions: [Transaction]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(transactions) { transaction in
                    TransactionRow(transaction: transaction)
                }
            }
        }
        .navigationTitle("History")
    }
}
