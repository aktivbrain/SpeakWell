import SwiftUI

struct WordAnalysisView: View {
    let words: [WordAssessment]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Word Analysis")
                .font(.headline)
                .foregroundColor(AppColors.primary)
            
            ForEach(words, id: \.word) { word in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(word.word)
                            .font(.body.bold())
                            .foregroundColor(AppColors.primary)
                        
                        Spacer()
                        
                        ErrorBadge(errorType: word.errorType)
                    }
                    
                    ScoreProgressBar(score: word.accuracyScore)
                        .frame(height: 6)
                    
                    HStack {
                        Text("Accuracy: \(Int(word.accuracyScore))%")
                            .font(.caption)
                            .foregroundColor(AppColors.primary.opacity(0.7))
                        
                        Spacer()
                        
                        Text("\(String(format: "%.1f", Double(word.duration) / 1_000_000))s")
                            .font(.caption)
                            .foregroundColor(AppColors.primary.opacity(0.7))
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: AppColors.primary.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview("Word Analysis") {
    WordAnalysisView(words: [
        WordAssessment(
            word: "Hello",
            offset: 0,
            duration: 500000,
            confidence: 0.95,
            accuracyScore: 85.0,
            errorType: "None"
        ),
        WordAssessment(
            word: "World",
            offset: 600000,
            duration: 400000,
            confidence: 0.92,
            accuracyScore: 65.0,
            errorType: "Mispronunciation"
        )
    ])
    .padding()
    .background(AppColors.background)
} 