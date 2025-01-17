import Foundation
import AVFoundation

enum AzureSpeechError: Error {
    case invalidAudioFormat
    case authenticationFailed
    case invalidResponse
    case networkError(Error)
    case noValidResults
}

class AzureSpeechService {
    private let speechKey = APIConfig.azureSpeechKey
    private let speechRegion = "eastus"
    private let baseUrl = "https://eastus.stt.speech.microsoft.com"
    
    // Get Azure token
    private func getAuthToken() async throws -> String {
        let tokenEndpoint = "https://\(speechRegion).api.cognitive.microsoft.com/sts/v1.0/issueToken"
        var request = URLRequest(url: URL(string: tokenEndpoint)!)
        request.httpMethod = "POST"
        request.setValue(speechKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200,
              let token = String(data: data, encoding: .utf8) else {
            throw AzureSpeechError.authenticationFailed
        }
        
        return token
    }
    
    // Prepare audio data according to Azure requirements
    private func prepareAudioData(_ audioData: Data) throws -> Data {
        // The audio data is already in the correct format (16-bit PCM, 16kHz, mono)
        // and has a proper WAV header from RecordingService
        return audioData
    }
    
    // Main assessment function
    func assessPronunciation(audioData: Data, referenceText: String) async throws -> PronunciationAssessmentResult {
        let baseUrl = "https://eastus.stt.speech.microsoft.com"
        let endpoint = "/speech/recognition/conversation/cognitiveservices/v1"
        let queryParams = "?language=en-US"
        
        guard let url = URL(string: baseUrl + endpoint + queryParams) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set required headers
        request.setValue("audio/wav; codecs=audio/pcm; samplerate=16000", forHTTPHeaderField: "Content-Type")
        request.setValue(speechKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.setValue("chunked", forHTTPHeaderField: "Transfer-Encoding")
        
        // Create pronunciation assessment config
        let assessmentConfig: [String: Any] = [
            "ReferenceText": referenceText,
            "GradingSystem": "HundredMark",
            "Granularity": "Word",
            "Dimension": "Comprehensive"
        ]
        
        // Convert config to JSON and then Base64
        if let jsonData = try? JSONSerialization.data(withJSONObject: assessmentConfig),
           let base64Config = jsonData.base64EncodedString().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            request.setValue(base64Config, forHTTPHeaderField: "Pronunciation-Assessment")
        }
        
        request.httpBody = audioData
        
        print("Sending request to Azure Speech Service...")
        print("URL: \(url)")
        print("Reference text: \(referenceText)")
        print("Audio data size: \(audioData.count) bytes")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        print("Response status code: \(httpResponse.statusCode)")
        
        if httpResponse.statusCode == 200 {
            do {
                let rawResponse = String(data: data, encoding: .utf8) ?? "Unable to decode response"
                print("Raw response: \(rawResponse)")
                
                let result = try JSONDecoder().decode(PronunciationAssessmentResult.self, from: data)
                print("Successfully decoded response")
                
                if let firstResult = result.nbest?.first {
                    print("Recognition status: \(result.recognitionStatus)")
                    print("Display text: \(firstResult.display ?? "")")
                    print("Confidence: \(firstResult.confidence)")
                    
                    print("Pronunciation score: \(firstResult.pronScore)")
                    print("Accuracy score: \(firstResult.accuracyScore)")
                    print("Fluency score: \(firstResult.fluencyScore)")
                    print("Completeness score: \(firstResult.completenessScore)")
                    
                    if let words = firstResult.words {
                        print("Words analyzed: \(words.count)")
                        for word in words {
                            print("Word: \(word.word), Accuracy: \(word.accuracyScore), Error: \(word.errorType)")
                        }
                    } else {
                        print("No word-level analysis available")
                    }
                }
                
                return result
            } catch {
                print("Decoding error: \(error)")
                throw NetworkError.decodingFailed(error)
            }
        } else {
            throw NetworkError.invalidResponse
        }
    }
}

// Extension to handle audio recording and format conversion
extension AzureSpeechService {
    func convertAudioToRequiredFormat(audioData: Data) throws -> Data {
        // Convert audio data to required format
        // This is a placeholder - you would need to implement actual conversion
        // using AVAudioConverter or similar
        
        return audioData
    }
}

// Add helper extension for WAV header
extension Data {
    mutating func appendWAVHeader(sampleRate: Int = 16000, bitDepth: Int = 16, channels: Int = 1) {
        let headerSize = 44
        let fileSize = count + headerSize - 8
        let chunk2Size = count + headerSize - 44
        
        // RIFF header
        append("RIFF".data(using: .ascii)!)
        append(withUInt32: UInt32(fileSize))
        append("WAVE".data(using: .ascii)!)
        
        // Format chunk
        append("fmt ".data(using: .ascii)!)
        append(withUInt32: 16)
        append(withUInt16: 1) // PCM format
        append(withUInt16: UInt16(channels))
        append(withUInt32: UInt32(sampleRate))
        append(withUInt32: UInt32(sampleRate * channels * bitDepth / 8))
        append(withUInt16: UInt16(channels * bitDepth / 8))
        append(withUInt16: UInt16(bitDepth))
        
        // Data chunk
        append("data".data(using: .ascii)!)
        append(withUInt32: UInt32(chunk2Size))
    }
    
    private mutating func append(withUInt32 value: UInt32) {
        var value = value
        append(Data(bytes: &value, count: 4))
    }
    
    private mutating func append(withUInt16 value: UInt16) {
        var value = value
        append(Data(bytes: &value, count: 2))
    }
} 