import SwiftUI

struct WordAnalysisView: View {
    let words: [WordAssessment]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Word Analysis")
                .font(.headline)
            
            ForEach(words, id: \.word) { word in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(word.word)
                            .font(.body.bold())
                        
                        Spacer()
                        
                        ErrorBadge(errorType: word.errorType)
                    }
                    
                    ScoreProgressBar(score: word.accuracyScore)
                        .frame(height: 6)
                    
                    HStack {
                        Text("Accuracy: \(Int(word.accuracyScore))%")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("\(String(format: "%.1f", Double(word.duration) / 1_000_000))s")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(.secondarySystemGroupedBackground))
                .cornerRadius(12)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }
}

#Preview {
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
    .background(Color(.systemGroupedBackground))
} 