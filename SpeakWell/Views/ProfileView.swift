import SwiftUI

struct ProfileView: View {
    @State private var isDarkMode = false
    @State private var notificationsEnabled = true
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Profile Header
                        VStack(spacing: 15) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(AppColors.accent)
                            
                            Text("User Name")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(AppColors.primary)
                            
                            Text("English Learner")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(AppColors.primary.opacity(0.8))
                        }
                        .padding(.top, 20)
                        
                        // Account Basics Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Account Basics")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(AppColors.primary)
                                .padding(.horizontal)
                            
                            NavigationLink(destination: Text("Profile Settings")) {
                                SettingsRow(icon: "person.fill", title: "Profile")
                            }
                            
                            NavigationLink(destination: Text("Name Settings")) {
                                SettingsRow(icon: "textformat", title: "Name")
                            }
                            
                            NavigationLink(destination: Text("Email Settings")) {
                                SettingsRow(icon: "envelope.fill", title: "Email")
                            }
                            
                            NavigationLink(destination: Text("Password Settings")) {
                                SettingsRow(icon: "lock.fill", title: "Password")
                            }
                            
                            NavigationLink(destination: Text("Profile Picture Settings")) {
                                SettingsRow(icon: "camera.fill", title: "Profile Picture")
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: AppColors.primary.opacity(0.1), radius: 5)
                        .padding(.horizontal)
                        
                        // App Settings Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("App Settings")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(AppColors.primary)
                                .padding(.horizontal)
                            
                            Toggle(isOn: $isDarkMode) {
                                SettingsRow(icon: "moon.fill", title: "Dark Mode")
                            }
                            .padding(.horizontal)
                            
                            Toggle(isOn: $notificationsEnabled) {
                                SettingsRow(icon: "bell.fill", title: "Notifications")
                            }
                            .padding(.horizontal)
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: AppColors.primary.opacity(0.1), radius: 5)
                        .padding(.horizontal)
                        
                        // Support Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Support")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(AppColors.primary)
                                .padding(.horizontal)
                            
                            NavigationLink(destination: Text("Help Center")) {
                                SettingsRow(icon: "questionmark.circle.fill", title: "Help")
                            }
                            
                            NavigationLink(destination: Text("Contact Support")) {
                                SettingsRow(icon: "envelope.fill", title: "Contact Support")
                            }
                            
                            NavigationLink(destination: Text("Terms of Service")) {
                                SettingsRow(icon: "doc.text.fill", title: "Terms of Service")
                            }
                            
                            NavigationLink(destination: Text("Privacy Policy")) {
                                SettingsRow(icon: "hand.raised.fill", title: "Privacy Policy")
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: AppColors.primary.opacity(0.1), radius: 5)
                        .padding(.horizontal)
                        
                        Spacer(minLength: 30)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Profile")
                        .font(.title.bold())
                        .foregroundColor(AppColors.primary)
                }
            }
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(AppColors.accent)
                .frame(width: 24, height: 24)
            
            Text(title)
                .font(.system(.body, design: .rounded))
                .foregroundColor(AppColors.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(AppColors.primary.opacity(0.5))
        }
        .padding()
        .background(Color.white)
    }
}

#Preview("Profile") {
    ProfileView()
} 