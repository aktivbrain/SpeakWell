import AVFoundation
import SwiftUI

class TextToSpeechService: ObservableObject {
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    @Published var isPlaying: Bool = false
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    func speak(_ text: String) {
        Task {
            do {
                await MainActor.run {
                    self.isLoading = true
                    self.error = nil
                }
                
                let response = try await NetworkingService.shared.generateSpeech(text: text)
                
                guard let url = URL(string: response.link) else {
                    throw NetworkError.invalidURL
                }
                
                // Create AVPlayerItem with the MP3 URL
                let asset = AVURLAsset(url: url)
                let playerItem = AVPlayerItem(asset: asset)
                
                await MainActor.run {
                    // Remove any existing observers
                    if let oldPlayerItem = self.playerItem {
                        NotificationCenter.default.removeObserver(self, 
                            name: .AVPlayerItemDidPlayToEndTime, 
                            object: oldPlayerItem)
                    }
                    
                    self.playerItem = playerItem
                    self.player = AVPlayer(playerItem: playerItem)
                    
                    // Add observer for playback end
                    NotificationCenter.default.addObserver(
                        self,
                        selector: #selector(self.playerDidFinishPlaying),
                        name: .AVPlayerItemDidPlayToEndTime,
                        object: playerItem
                    )
                    
                    // Start playback
                    self.player?.play()
                    self.isPlaying = true
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.error = error.localizedDescription
                    self.isLoading = false
                    self.isPlaying = false
                    print("🔴 Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func stop() {
        Task {
            await MainActor.run {
                player?.pause()
                player?.seek(to: .zero)
                isPlaying = false
            }
        }
    }
    
    @objc private func playerDidFinishPlaying() {
        Task {
            await MainActor.run {
                isPlaying = false
                player?.seek(to: .zero)
            }
        }
    }
    
    deinit {
        if let playerItem = playerItem {
            NotificationCenter.default.removeObserver(self, 
                name: .AVPlayerItemDidPlayToEndTime, 
                object: playerItem)
        }
    }
} 