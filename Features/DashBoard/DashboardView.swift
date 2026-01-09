import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @State private var activeSheet: ActiveSheet?
    @State private var showProfile = false
    @State private var profileViewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    headerBackground
                        .frame(height: 320)
                        .ignoresSafeArea(edges: .top)
                    Color(.systemBackground)
                }
                .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        dashboardHeader
                        transactionsList
                    }
                }
                .background(.clear)
                .sheet(item: $activeSheet) { sheet in
                    sheetView(sheet)
                }
                .navigationDestination(isPresented: $showProfile) {
                    ProfileView()
                }
                .ignoresSafeArea(edges: .top)
            }
        }
    }
    
    private var dashboardHeader: some View {
        VStack(alignment: .leading) {
            // MARK: - top bar
            HStack {
                Button {
                    showProfile = true
                } label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.white)
                }
                VStack(alignment: .leading) {
                    Text("Hi, \(profileViewModel.profile.firstName)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                    Text(profileViewModel.profile.email)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white.opacity(0.7))
                }
                Spacer()
                
                Button {
                    // future menu
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.white)
                }
            }
            
            //MARK: - Balance
            BalanceCardView(balance: viewModel.balance)
            
            //MARK: - Active buttons
            actionButtons
        }
        .padding()
        .padding(.top, 50)
        .padding(.bottom, 14)
        .background(
            headerBackground
                .ignoresSafeArea(edges: .top)
        )
    }
    
    private var headerBackground: some View {
        LinearGradient(
            colors: [.blue, .indigo],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    private var actionButtons: some View {
        HStack(spacing: 16) {
            ActionButton(title: "Add", systemImage: "plus") {
                activeSheet = .add
            }
            ActionButton(title: "History", systemImage: "receipt") {
                activeSheet = .history
            }
            ActionButton(title: "Goal (-)", systemImage: "chart.pie") {
                activeSheet = .history
            }
            ActionButton(title: "Notifications (-)", systemImage: "bell") {
                activeSheet = .history
            }
        }
    }
    
    private var transactionsList: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.transactions) { transaction in
                TransactionRow(transaction: transaction)
                    .padding(.horizontal, 20)
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

#Preview {
    DashboardView()
}
