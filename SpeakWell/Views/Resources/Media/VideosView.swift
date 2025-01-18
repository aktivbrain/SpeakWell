import SwiftUI

struct VideosView: View {
    var body: some View {
        Text("Tutorial videos will appear here")
            .navigationTitle("Videos")
    }
}

#Preview("Videos") {
    NavigationView {
        VideosView()
    }
} 