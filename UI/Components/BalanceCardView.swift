import SwiftUI

struct BalanceCardView: View {
    var balance: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Total balance")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
            Text(balanceFormatted)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(background)
        .cornerRadius(20)
    }
    
    private var balanceFormatted: String {
        String(format: "$%.2f", balance)
    }
    
    private var background: some View {
        LinearGradient(
            colors: [.blue, .indigo],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
