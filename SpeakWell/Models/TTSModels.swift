import Foundation

struct VoiceObject: Codable {
    let id: Int
    let voice_id: String
    let gender: String
    let language_code: String
    let language_name: String
    let voice_name: String
    let sample_text: String
    let sample_audio_url: String
    let status: Int
    let rank: Int
    let type: String
    let isPlaying: Bool
    
    init() {
        self.id = 2014
        self.voice_id = "en-US-Neural2-A"
        self.gender = "Male"
        self.language_code = "en-US"
        self.language_name = "US English"
        self.voice_name = "John"
        self.sample_text = "Hello, hope you are having a great time making your video."
        self.sample_audio_url = "https://s3.ap-south-1.amazonaws.com/invideo-uploads-ap-south-1/speechen-US-Neural2-A16831901130600.mp3"
        self.status = 2
        self.rank = 0
        self.type = "google_tts"
        self.isPlaying = false
    }
    
    // Add custom coding keys to silence warnings
    private enum CodingKeys: String, CodingKey {
        case id
        case voice_id
        case gender
        case language_code
        case language_name
        case voice_name
        case sample_text
        case sample_audio_url
        case status
        case rank
        case type
        case isPlaying
    }
}

struct TextBlock: Codable {
    let block_index: Int
    let text: String
}

struct TTSRequest: Codable {
    let voice_obj: VoiceObject
    let json_data: [TextBlock]
}

struct TTSResponseItem: Codable {
    let link: String
    let block_index: Int
    let duration: Double
    let size: Int
}

struct TTSResponse: Codable {
    let link: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let responseArray = try container.decode([TTSResponseItem].self)
        
        guard let firstResponse = responseArray.first else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Empty response array"
            )
        }
        
        self.link = firstResponse.link
    }
} 