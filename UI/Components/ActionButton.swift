import SwiftUI

struct ActionButton: View {
    let title: String
    let systemImage: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ActionButtonContent(title: title, systemImage: systemImage)
        }
        .buttonStyle(.plain)
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    ActionButton(title: "Add", systemImage: "plus") {
        
    }
}
