final class MockStorageService: StorageServiceProtocol {
    private var transactions: [Transaction] = []
    
    func fetchTransactions() -> [Transaction] {
        transactions
    }
    
    func save(transaction: Transaction) {
        transactions.insert(transaction, at: 0)
    }
}
