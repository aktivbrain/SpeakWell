import Foundation

struct PronunciationAnalysisRequest: Codable {
    let text: String
    let recording_url: String
}

struct PronunciationScore: Codable {
    let accuracy: Double
    let fluency: Double
    let completeness: Double
    let overall: Double
}

struct PronunciationAnalysisResponse: Codable {
    let scores: PronunciationScore
    let feedback: String
} 