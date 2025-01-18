//
//  ContentView.swift
//  SpeakWell
//
//  Created by ricardo serrano on 1/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            AnalysisView()
                .tabItem {
                    Image(systemName: "waveform")
                    Text("Analysis")
                }
                .tag(1)
            
            ResourcesView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Resources")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
        }
        .tint(AppColors.accent)
        .background(AppColors.background)
    }
}

#Preview("Main App") {
    ContentView()
}
