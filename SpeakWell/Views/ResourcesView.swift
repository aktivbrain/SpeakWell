import SwiftUI

struct ResourcesView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Learning Materials")) {
                    ForEach(1...5, id: \.self) { _ in
                        NavigationLink(destination: Text("Resource Detail")
                            .foregroundColor(.appText)) {
                            HStack {
                                Image(systemName: "book.fill")
                                    .foregroundColor(.appInteractive)
                                Text("Practice Resource")
                                    .foregroundColor(.appText)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Resources")
            .background(Color.appBackground)
            .scrollContentBackground(.hidden)
        }
    }
} 