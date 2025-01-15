import SwiftUI

struct AnalysisResultsView: View {
    let scores: PronunciationScore
    let feedback: String
    let recordedText: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Pronunciation Analysis")
                    .font(.title)
                    .foregroundColor(.appText)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Your Speech")
                        .font(.headline)
                        .foregroundColor(.appText)
                    
                    Text(recordedText)
                        .foregroundColor(.appText)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.appInteractive.opacity(0.2))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                ScoreCard(title: "Overall Score", score: scores.overall)
                
                VStack(spacing: 15) {
                    ScoreCard(title: "Accuracy", score: scores.accuracy)
                    ScoreCard(title: "Fluency", score: scores.fluency)
                    ScoreCard(title: "Completeness", score: scores.completeness)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Feedback")
                        .font(.headline)
                        .foregroundColor(.appText)
                    
                    Text(feedback)
                        .foregroundColor(.appText.opacity(0.8))
                        .padding()
                        .background(Color.appInteractive.opacity(0.2))
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
        .background(Color.appBackground)
    }
}

struct ScoreCard: View {
    let title: String
    let score: Double
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.appText)
            Spacer()
            Text("\(Int(score * 100))%")
                .foregroundColor(scoreColor)
                .bold()
        }
        .padding()
        .background(Color.appInteractive.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var scoreColor: Color {
        if score >= 0.8 { return .appHighlight }
        if score >= 0.6 { return .appText }
        return .appError
    }
} 