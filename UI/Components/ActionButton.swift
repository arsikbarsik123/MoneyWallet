import SwiftUI

struct ActionButton: View {
    let title: String
    let systemImage: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: systemImage)
                    .font(.title2)
                    .foregroundStyle(.blue)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.primary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(background)
            .cornerRadius(14)
        }
        .buttonStyle(.plain)
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(.ultraThinMaterial)
    }
}
