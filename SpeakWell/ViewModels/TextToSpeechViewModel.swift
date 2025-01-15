import SwiftUI

class TextToSpeechViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var isPlaying: Bool = false
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    private let ttsService: TextToSpeechService
    
    init() {
        self.ttsService = TextToSpeechService()
        // Set up observation of service properties
        setupObservers()
    }
    
    private func setupObservers() {
        // Observe service properties
        ttsService.$isPlaying.assign(to: &$isPlaying)
        ttsService.$isLoading.assign(to: &$isLoading)
        ttsService.$error.assign(to: &$error)
    }
    
    func convertToSpeech() {
        guard !inputText.isEmpty else { return }
        Task {
            await MainActor.run {
                isLoading = true
            }
            ttsService.speak(inputText)
        }
    }
    
    func stopSpeech() {
        ttsService.stop()
    }
} 