import SwiftUI

struct ErrorBadge: View {
    let errorType: String
    
    var body: some View {
        if errorType != "None" {
            Text(errorType)
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.red)
                .cornerRadius(8)
        }
    }
}

#Preview {
    HStack {
        ErrorBadge(errorType: "Mispronunciation")
        ErrorBadge(errorType: "None")
    }
    .padding()
} 