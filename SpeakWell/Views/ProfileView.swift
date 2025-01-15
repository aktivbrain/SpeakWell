import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.appInteractive)
                        
                        VStack(alignment: .leading) {
                            Text("User Name")
                                .font(.title2)
                                .foregroundColor(.appText)
                            Text("English Learner")
                                .foregroundColor(.appText.opacity(0.8))
                        }
                    }
                    .padding(.vertical, 10)
                }
                
                Section(header: Text("Settings")) {
                    NavigationLink(destination: Text("Account Settings")
                        .foregroundColor(.appText)) {
                        Label("Account", systemImage: "person.fill")
                            .foregroundColor(.appText)
                    }
                    
                    NavigationLink(destination: Text("Preferences")
                        .foregroundColor(.appText)) {
                        Label("Preferences", systemImage: "gear")
                            .foregroundColor(.appText)
                    }
                }
            }
            .navigationTitle("Profile")
            .background(Color.appBackground)
            .scrollContentBackground(.hidden)
        }
    }
} 