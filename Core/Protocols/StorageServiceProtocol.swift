protocol StorageServiceProtocol {
    func fetchTransactions() -> [Transaction]
    func save(transaction: Transaction)
}


