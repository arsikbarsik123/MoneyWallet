import SwiftUI

final class DashboardViewModel: ObservableObject {
    @Published private(set) var transactions: [Transaction] = []
    
    private let storage: StorageServiceProtocol
    
    init(storage: StorageServiceProtocol = MockStorageService()) {
        self.storage = storage
        load()
    }
    
    var balance: Double {
        transactions.reduce(0) {
            $0 + ($1.type == .income ? $1.amount : -$1.amount)
        }
    }
    
    func add(transaction: Transaction) {
        storage.save(transaction: transaction)
        load()
    }
    
    func load() {
        transactions = storage.fetchTransactions()
    }
}
