import SwiftUI

struct HomeView: View {
    @State private var isLogoAnimating = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                // App logo with animation
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 40)
                    .scaleEffect(isLogoAnimating ? 1.0 : 0.8)
                    .opacity(isLogoAnimating ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 1.0), value: isLogoAnimating)
                
                // Welcome text with shadow
                Text("Welcome to SpeakWell")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(AppColors.primary)
                    .shadow(color: AppColors.primary.opacity(0.2), radius: 2, x: 0, y: 2)
                    .opacity(isLogoAnimating ? 1.0 : 0.0)
                    .offset(y: isLogoAnimating ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.3), value: isLogoAnimating)
                
                // Subtitle with gradient
                Text("Improve your English pronunciation")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(AppColors.primary.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(isLogoAnimating ? 1.0 : 0.0)
                    .offset(y: isLogoAnimating ? 0 : 20)
                    .animation(.easeOut(duration: 0.8).delay(0.5), value: isLogoAnimating)
                
                Spacer()
                
                // Practice button with shadow and animation
                Button(action: {
                    // Start practice action
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "mic.fill")
                            .font(.system(size: 20))
                        Text("Start Practice")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(AppColors.primary)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(color: AppColors.primary.opacity(0.3), radius: 5, x: 0, y: 3)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
                .opacity(isLogoAnimating ? 1.0 : 0.0)
                .offset(y: isLogoAnimating ? 0 : 20)
                .animation(.easeOut(duration: 0.8).delay(0.7), value: isLogoAnimating)
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(AppColors.background)
            .onAppear {
                isLogoAnimating = true
            }
        }
    }
}

#Preview("Home") {
    HomeView()
} 