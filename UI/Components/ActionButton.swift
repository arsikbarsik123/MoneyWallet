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
    }
}

#Preview {
    ActionButton(title: "Add", systemImage: "plus") {
        
    }
}
