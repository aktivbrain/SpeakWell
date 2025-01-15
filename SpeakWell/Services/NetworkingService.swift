import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
    case emptyResponse
    case invalidResponseFormat
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .emptyResponse:
            return "Empty response from server"
        case .invalidResponseFormat:
            return "Invalid response format from server"
        }
    }
}

class NetworkingService {
    static let shared = NetworkingService()
    
    private let apiKey = "5e2811e960msh3d1f035ffed53bbp1e6b45jsn0602ddc4b4f3"
    private let baseURL = "https://realistic-text-to-speech.p.rapidapi.com/v3/generate_voice_over_v2"
    
    private init() {}
    
    func generateSpeech(text: String) async throws -> TTSResponse {
        guard let url = URL(string: baseURL) else {
            print("❌ Invalid URL")
            throw NetworkError.invalidURL
        }
        
        // Create request body
        let textBlock = TextBlock(block_index: 0, text: text)
        let requestBody = TTSRequest(
            voice_obj: VoiceObject(),
            json_data: [textBlock]
        )
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("realistic-text-to-speech.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        // Encode request body
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(requestBody)
        
        print("📡 Making API request...")
        print("📤 Request body: \(String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "")")
        
        // Make request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("❌ Invalid response type")
            throw NetworkError.invalidResponse
        }
        
        print("📥 Response status code: \(httpResponse.statusCode)")
        print("📦 Raw response: \(String(data: data, encoding: .utf8) ?? "No data")")
        
        guard (200...299).contains(httpResponse.statusCode) else {
            print("❌ Error response: \(String(data: data, encoding: .utf8) ?? "No data")")
            throw NetworkError.invalidResponse
        }
        
        // Decode response
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(TTSResponse.self, from: data)
            print("✅ Successfully decoded response: \(response)")
            return response
        } catch {
            print("❌ Decoding error: \(error)")
            throw NetworkError.decodingFailed(error)
        }
    }
} 