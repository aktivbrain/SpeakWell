import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to SpeakWell")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.appText)
                
                Text("Improve your English pronunciation")
                    .font(.subheadline)
                    .foregroundColor(.appText.opacity(0.8))
                
                Button(action: {
                    // Start practice action
                }) {
                    HStack {
                        Image(systemName: "mic.fill")
                        Text("Start Practice")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appInteractive)
                    .foregroundColor(.appText)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.appBackground)
        }
    }
} 