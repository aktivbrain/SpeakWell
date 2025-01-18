import SwiftUI

struct ScoreDetail: Identifiable {
    let id = UUID()
    let title: String
    let score: Double
    let icon: String
}

struct DetailedScoresView: View {
    let accuracyScore: Double
    let fluencyScore: Double
    let completenessScore: Double
    
    private var scores: [ScoreDetail] {
        [
            ScoreDetail(title: "Accuracy", score: accuracyScore, icon: "mic.circle.fill"),
            ScoreDetail(title: "Fluency", score: fluencyScore, icon: "waveform.circle.fill"),
            ScoreDetail(title: "Completeness", score: completenessScore, icon: "checkmark.circle.fill")
        ]
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Detailed Scores")
                .font(.headline)
                .foregroundColor(AppColors.primary)
            
            ForEach(scores) { score in
                HStack {
                    Label(score.title, systemImage: score.icon)
                        .foregroundColor(AppColors.primary)
                    
                    Spacer()
                    
                    ScoreProgressBar(score: score.score)
                        .frame(width: 100, height: 8)
                    
                    Text("\(Int(score.score))")
                        .font(.callout.monospacedDigit())
                        .foregroundColor(AppColors.primary.opacity(0.7))
                        .frame(width: 30, alignment: .trailing)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: AppColors.primary.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview("Detailed Scores") {
    DetailedScoresView(
        accuracyScore: 85.0,
        fluencyScore: 92.5,
        completenessScore: 75.0
    )
    .padding()
    .background(AppColors.background)
} 