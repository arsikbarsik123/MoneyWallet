import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            List {
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
    }
    
    private var header: some View {
        VStack(spacing: 12) {
            avatarPicker
            
            Text("\(viewModel.profile.firstName) \(viewModel.profile.surname)")
                .font(.title3.bold())
            Text(viewModel.profile.email)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
    }
    
    private var avatarPicker: some View {
        PhotosPicker(
            selection: $viewModel.selectedPhoto,
            matching: .images,
        ) {
            avatarView
        }
        .onChange(of: viewModel.selectedPhoto) { _ in
            Task {
                await viewModel.loadAvatarImage()
            }
        }
    }
    
    @ViewBuilder
    private var avatarView: some View {
        Group {
            if let data = viewModel.profile.avatarImageData,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: viewModel.profile.avatarSystemName)
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 96, height: 96)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.blue.opacity(0.3), lineWidth: 2)
        )
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
