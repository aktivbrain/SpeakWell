import SwiftUI

struct RecordedSpeechView: View {
    let displayText: String
    let snr: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your Speech")
                .font(.headline)
            
            Text(displayText)
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemGroupedBackground))
                .cornerRadius(10)
            
            HStack {
                Label("Audio Quality", systemImage: "waveform")
                Spacer()
                Text("\(Int(snr))dB")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }
}

#Preview {
    RecordedSpeechView(
        displayText: "Hello, how are you?",
        snr: 35.5
    )
    .padding()
    .background(Color(.systemGroupedBackground))
} 