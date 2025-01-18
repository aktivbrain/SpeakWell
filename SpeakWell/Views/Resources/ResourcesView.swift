import SwiftUI

struct ResourcesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Sound Library Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Sound Library")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(AppColors.primary)
                                .padding(.horizontal)
                            
                            HStack(spacing: 15) {
                                NavigationLink(destination: VowelSoundsView()) {
                                    ResourceBox(
                                        icon: "waveform.path",
                                        title: "Vowels",
                                        description: "Practice vowel sounds"
                                    )
                                }
                                
                                NavigationLink(destination: ConsonantSoundsView()) {
                                    ResourceBox(
                                        icon: "waveform.path.ecg",
                                        title: "Consonants",
                                        description: "Practice consonant sounds"
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Bookmarks Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Bookmarks")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(AppColors.primary)
                                .padding(.horizontal)
                            
                            NavigationLink(destination: BookmarksView()) {
                                HStack {
                                    ResourceBox(
                                        icon: "bookmark.fill",
                                        title: "Saved Items",
                                        description: "View your bookmarked content"
                                    )
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Placement Images Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Placement Images")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(AppColors.primary)
                                .padding(.horizontal)
                            
                            NavigationLink(destination: PlacementImagesView()) {
                                HStack {
                                    ResourceBox(
                                        icon: "photo.fill",
                                        title: "Tongue Placement",
                                        description: "Visual guides for pronunciation"
                                    )
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Videos Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Videos")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(AppColors.primary)
                                .padding(.horizontal)
                            
                            NavigationLink(destination: VideosView()) {
                                HStack {
                                    ResourceBox(
                                        icon: "play.rectangle.fill",
                                        title: "Tutorial Videos",
                                        description: "Watch pronunciation guides"
                                    )
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        Spacer(minLength: 30)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Resources")
                        .font(.title.bold())
                        .foregroundColor(AppColors.primary)
                }
            }
        }
    }
}

#Preview("Resources") {
    ResourcesView()
} 