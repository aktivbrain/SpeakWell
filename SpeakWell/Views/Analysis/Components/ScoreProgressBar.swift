import SwiftUI

struct ScoreProgressBar: View {
    let score: Double
    let height: CGFloat
    
    init(score: Double, height: CGFloat = 8) {
        self.score = score
        self.height = height
    }
    
    private func getScoreColor(_ score: Double) -> Color {
        switch score {
        case 90...100: return .green
        case 70..<90: return .blue
        case 50..<70: return .orange
        default: return .red
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: height)
                    .opacity(0.1)
                    .foregroundColor(.accentColor)
                
                Rectangle()
                    .frame(width: geometry.size.width * score / 100, height: height)
                    .foregroundColor(getScoreColor(score))
            }
            .cornerRadius(height / 2)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ScoreProgressBar(score: 95)
            .frame(height: 8)
        ScoreProgressBar(score: 75)
            .frame(height: 8)
        ScoreProgressBar(score: 45)
            .frame(height: 8)
    }
    .padding()
} 