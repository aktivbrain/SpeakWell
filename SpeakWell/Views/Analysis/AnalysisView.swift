import SwiftUI

struct AnalysisView: View {
    @State private var showingTextInput = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("AI Speech Analysis")
                    .font(.largeTitle)
                    .foregroundColor(.appText)
                    .padding()
                
                Circle()
                    .stroke(Color.appInteractive, lineWidth: 4)
                    .frame(width: 200, height: 200)
                    .overlay(
                        Image(systemName: "waveform")
                            .font(.system(size: 70))
                            .foregroundColor(.appInteractive)
                    )
                
                Text("Tap to start recording")
                    .foregroundColor(.appText.opacity(0.8))
                    .padding()
                
                Button(action: {
                    showingTextInput = true
                }) {
                    HStack {
                        Image(systemName: "text.bubble.fill")
                        Text("Text to Speech")
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
            .sheet(isPresented: $showingTextInput) {
                TextInputView()
            }
        }
    }
} 