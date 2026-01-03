import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            icon
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.body)
                    .fontWeight(.medium)
                Text(transaction.date, style: .date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(amountFormatted)
                .font(.body.bold())
                .foregroundStyle(amountColor)
        }
        .padding(.vertical, 8)
    }
    
    private var icon: some View {
        Circle()
            .fill(amountColor.opacity(0.15))
            .frame(width: 36, height: 36)
            .overlay {
                Image(systemName: iconName)
                    .foregroundStyle(amountColor)
            }
    }
    
    private var amountFormatted: String {
        let sign = transaction.type == .income ? "+" : "-"
        return "\(sign)\(transaction.amount)"
    }
    
    private var amountColor: Color {
        transaction.type == .income ? .green : .red
    }
    
    private var iconName: String {
        transaction.type == .income ? "arrow.down" : "arrow.up"
    }
}
