import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @State private var activeSheet: ActiveSheet?
    @State private var showProfile = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    topBar
                    BalanceCardView(balance: viewModel.balance)
                    actionButtons
                    transactionsList
                }
                .padding()
            }
            .sheet(item: $activeSheet) { sheet in
                sheetView(sheet)
            }
            .navigationDestination(isPresented: $showProfile) {
                ProfileView()
            }
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: 16) {
            ActionButton(title: "Add", systemImage: "plus") {
                activeSheet = .add
            }
            ActionButton(title: "History", systemImage: "list.bullet") {
                activeSheet = .history
            }
        }
    }
    
    private var transactionsList: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.transactions) { transaction in
                TransactionRow(transaction: transaction)
            }
        }
    }
    
    private var topBar: some View {
        HStack {
            Spacer()
            Button {
                showProfile = true
            } label: {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
        }
    }
    
    @ViewBuilder func sheetView(_ sheet: ActiveSheet) -> some View {
        switch sheet {
        case .add:
            AddTransactionView { transaction in
                viewModel.add(transaction: transaction)
            }
        case .history:
            HistoryView(transactions: viewModel.transactions)
        }
    }
}

enum ActiveSheet: Identifiable {
    case add
    case history
    
    var id: Int { hashValue }
}
