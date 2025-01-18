import SwiftUI

struct ConsonantSoundsView: View {
    var body: some View {
        List {
            ForEach(["B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"], id: \.self) { consonant in
                NavigationLink(destination: Text("Practice \(consonant) sound")) {
                    Text(consonant)
                }
            }
        }
        .navigationTitle("Consonant Sounds")
    }
}

#Preview("Consonant Sounds") {
    NavigationView {
        ConsonantSoundsView()
    }
} 