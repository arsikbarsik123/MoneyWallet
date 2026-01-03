import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        List {
            header
            
            Section {
                infoRow("Email", viewModel.profile.email)
                infoRow("Currency", "USD")
                infoRow("Language", "English")
            }
            
            Section {
                infoRow("About App", "MoneyWallet v1.0")
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var header: some View {
        VStack(spacing: 12) {
            Image(systemName: viewModel.profile.avatar)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.blue)
            
            Text(viewModel.profile.name)
                .font(.title3.bold())
            
            Text(viewModel.profile.email)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
    }
    
    func infoRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
}
