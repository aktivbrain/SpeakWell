import SwiftUI

struct OverallScoreView: View {
    let score: Double
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Overall Score")
                .font(.headline)
            
            ZStack {
                Circle()
                    .stroke(Color(.systemGray5), lineWidth: 20)
                    .frame(width: 150, height: 150)
                
                Circle()
                    .trim(from: 0, to: score / 100)
                    .stroke(
                        Color.accentColor,
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(score))")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
            }
            
            Text("Based on accuracy, fluency, and completeness")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
    }
}

#Preview {
    OverallScoreView(score: 85.5)
        .padding()
        .background(Color(.systemGroupedBackground))
} 