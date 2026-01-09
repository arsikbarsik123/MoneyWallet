import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @State private var activeSheet: ActiveSheet?
    @State private var profileViewModel = ProfileViewModel()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
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
            }
            .background(.clear)
            .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .add:
                    sheetView(sheet)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .profile:
                    ProfileView()
                case .history:
                    HistoryView(transactions: viewModel.transactions)
                case .goal:
                    GoalView()
                case .notification:
                    NotificationView()
                }
                
            }
            .ignoresSafeArea(edges: .top)
        }
    }
    
    private var dashboardHeader: some View {
        VStack(alignment: .leading) {
            // MARK: - top bar
            HStack {
                NavigationLink(value: Route.profile) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
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
            Button {
                activeSheet = .add
            } label: {
                ActionButton(title: "Add", systemImage: "plus") {
                    activeSheet = .add
                }
            }
            .buttonStyle(.plain)

            NavigationLink(value: Route.history) {
                ActionButtonContent(title: "History", systemImage: "receipt")
            }
            
            NavigationLink(value: Route.goal) {
                ActionButtonContent(title: "Goal (-)", systemImage: "chart.pie")
            }
            
            NavigationLink(value: Route.notification) {
                ActionButtonContent(
                    title: "Notifications (-)",
                    systemImage: "bell"
                ) 
            }
            
        }
    }
    
    private var transactionsList: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Last transactions:")
                    .font(.system(size: 25))
                    .foregroundStyle(.opacity(0.7))
                Spacer()
                NavigationLink(value: Route.history) {
                    Text("See all")
                        .font(.system(size: 20))
                        .foregroundStyle(.black.opacity(0.5))
                }
            }
            .padding(.horizontal, 20)
            
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
        }
    }
}

enum ActiveSheet: Identifiable {
    case add
    
    var id: Int { hashValue }
}

private enum Route: Hashable {
    case profile
    case history
    case goal
    case notification
}

#Preview {
    DashboardView()
}
