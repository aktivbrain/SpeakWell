import SwiftUI

struct BookmarksView: View {
    var body: some View {
        Text("Your bookmarked items will appear here")
            .navigationTitle("Bookmarks")
    }
}

#Preview("Bookmarks") {
    NavigationView {
        BookmarksView()
    }
} 