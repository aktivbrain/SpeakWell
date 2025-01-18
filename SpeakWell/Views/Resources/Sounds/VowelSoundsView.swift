import SwiftUI

struct VowelSoundsView: View {
    var body: some View {
        List {
            ForEach(["A", "E", "I", "O", "U"], id: \.self) { vowel in
                NavigationLink(destination: Text("Practice \(vowel) sound")) {
                    Text(vowel)
                }
            }
        }
        .navigationTitle("Vowel Sounds")
    }
}

#Preview("Vowel Sounds") {
    NavigationView {
        VowelSoundsView()
    }
} 