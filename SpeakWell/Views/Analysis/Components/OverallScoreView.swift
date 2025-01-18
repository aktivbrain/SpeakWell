import SwiftUI

struct OverallScoreView: View {
    let score: Double
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Overall Score")
                .font(.headline)
                .foregroundColor(AppColors.primary)
            
            ZStack {
                Circle()
                    .stroke(AppColors.primary.opacity(0.1), lineWidth: 20)
                    .frame(width: 150, height: 150)
                
                Circle()
                    .trim(from: 0, to: score / 100)
                    .stroke(
                        score >= 70 ? AppColors.primary : AppColors.accent,
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(score))")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundColor(AppColors.primary)
            }
            
            Text("Based on accuracy, fluency, and completeness")
                .font(.subheadline)
                .foregroundColor(AppColors.primary.opacity(0.7))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: AppColors.primary.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview("Overall Score") {
    OverallScoreView(score: 85.5)
        .padding()
        .background(AppColors.background)
} 