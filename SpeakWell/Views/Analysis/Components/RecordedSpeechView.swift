import SwiftUI

struct RecordedSpeechView: View {
    let displayText: String
    let snr: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your Speech")
                .font(.headline)
                .foregroundColor(AppColors.primary)
            
            Text(displayText)
                .font(.body)
                .foregroundColor(AppColors.primary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppColors.background)
                .cornerRadius(10)
            
            HStack {
                Label("Audio Quality", systemImage: "waveform")
                    .foregroundColor(AppColors.primary.opacity(0.7))
                Spacer()
                Text("\(Int(snr))dB")
                    .foregroundColor(AppColors.primary.opacity(0.7))
            }
            .font(.subheadline)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: AppColors.primary.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview("Recorded Speech") {
    RecordedSpeechView(
        displayText: "Hello, how are you?",
        snr: 35.5
    )
    .padding()
    .background(AppColors.background)
} 