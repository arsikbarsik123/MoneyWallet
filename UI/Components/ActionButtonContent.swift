import SwiftUI

struct ActionButtonContent: View {
    let title: String
    let systemImage: String
    
    var body: some View {
        VStack {
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
            .buttonStyle(.plain)
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.85))
        }
        .frame(maxWidth: .infinity)
    }
}
