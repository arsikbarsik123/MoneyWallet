import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var profile: UserProfile
    
    init() {
        self.profile = UserProfile(
            name: "Arsalan Shirapov",
            email: "arsikbarsik@gmail.com",
            avatar: "person.crop.circle.fill"
        )
    }
}
