import SwiftUI

struct ActionButton: View {
    let title: String
    let systemImage: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .overlay(
                            Circle().stroke(.white.opacity(0.18), lineWidth: 1)
                        )
                    Image(systemName: systemImage)
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
                .frame(width: 56, height: 56)
            }
            .buttonStyle(.plain)
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.85))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ActionButton(title: "Add", systemImage: "plus") {
        
    }
}
