import SwiftUI

struct BalanceCardView: View {
    var balance: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Total balance")
                .font(.system(size: 25))
                .foregroundStyle(.white.opacity(0.7))
            Text(balanceFormatted)
                .font(.system(size: 50))
                .foregroundStyle(.white)
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
    
    private var balanceFormatted: String {
        String(format: "$%.2f", balance)
    }
}

#Preview {
    BalanceCardView(balance: 1000000)
}
