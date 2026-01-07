import SwiftUI
import PhotosUI

final class ProfileViewModel: ObservableObject {
    @Published var profile: UserProfile
    @Published var selectedPhoto: PhotosPickerItem?
    
    init() {
        self.profile = UserProfile(
            firstName: "Arsalan",
            surname: "Shirapov",
            email: "arsikbarsik@gmail.com",
            avatarSystemName: "person.crop.circle.fill",
            avatarImageData: nil
        )
    }
    
    @MainActor func loadAvatarImage() async {
        guard let selectedPhoto else { return }
        
        if let data = try? await selectedPhoto.loadTransferable(type: Data.self) {
            profile.avatarImageData = data
        }
    }
}
