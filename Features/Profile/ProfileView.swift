import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        List {
            Section {
                header
            }
            .listRowInsets(.init(top: 12, leading: 16, bottom: 12, trailing: 16))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)

            Section {
                infoRow("Email", viewModel.profile.email)
                infoRow("Currency", "USD")
                infoRow("Language", "English")
            }

            Section {
                infoRow("About App", "MoneyWallet v1.0")
            }
        }
        .listStyle(.insetGrouped)              // вот “тот самый” вид секций
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var header: some View {
        VStack(spacing: 12) {
            avatarPicker
                .buttonStyle(.plain)
            
            Text("\(viewModel.profile.firstName) \(viewModel.profile.surname)")
                .font(.title3.bold())
                .allowsHitTesting(false)
            Text(viewModel.profile.email)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .allowsHitTesting(false)
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
        .frame(width: 96, height: 96)
        .contentShape(Circle())
        .clipShape(Circle())
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
        .contentShape(Circle())
        .clipShape(Circle())
        
    }
    
    func infoSection<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 0) {
            content()
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
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

//#Preview {
//    ProfileView(viewModel: )
//}
