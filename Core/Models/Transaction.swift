import Foundation

struct Transaction: Identifiable, Codable {
    let id: UUID
    let title: String
    let amount: Double
    let date: Date
    let type: TransactionType
}
