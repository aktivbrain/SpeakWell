import SwiftUI

struct AnalysisView: View {
    @State private var showingTextInput = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background.ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // App Logo
                    Image("AppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    // Record button
                    Button(action: {
                        showingTextInput = true
                    }) {
                        ZStack {
                            Circle()
                                .stroke(AppColors.accent, lineWidth: 2)
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "mic.fill")
                                .font(.system(size: 30))
                                .foregroundColor(AppColors.accent)
                        }
                    }
                    
                    Text("Tap to start recording")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(AppColors.primary.opacity(0.8))
                    
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("AI Speech Analysis")
                        .font(.title.bold())
                        .foregroundColor(AppColors.primary)
                }
            }
            .sheet(isPresented: $showingTextInput) {
                TextInputView()
            }
        }
    }
}

#Preview("Analysis") {
    AnalysisView()
} 