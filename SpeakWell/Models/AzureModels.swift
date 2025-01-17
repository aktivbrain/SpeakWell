import Foundation

// Response models for Azure Speech Service
struct PronunciationAssessmentResult: Codable {
    let recognitionStatus: String
    let offset: Int
    let duration: Int
    let displayText: String
    let snr: Double
    let nbest: [NBestResult]?
    
    enum CodingKeys: String, CodingKey {
        case recognitionStatus = "RecognitionStatus"
        case offset = "Offset"
        case duration = "Duration"
        case displayText = "DisplayText"
        case snr = "SNR"
        case nbest = "NBest"
    }
}

struct NBestResult: Codable {
    let confidence: Double
    let lexical: String
    let itn: String?
    let maskedITN: String?
    let display: String?
    let accuracyScore: Double
    let fluencyScore: Double
    let completenessScore: Double
    let pronScore: Double
    let words: [WordAssessment]?
    
    enum CodingKeys: String, CodingKey {
        case confidence = "Confidence"
        case lexical = "Lexical"
        case itn = "ITN"
        case maskedITN = "MaskedITN"
        case display = "Display"
        case accuracyScore = "AccuracyScore"
        case fluencyScore = "FluencyScore"
        case completenessScore = "CompletenessScore"
        case pronScore = "PronScore"
        case words = "Words"
    }
}

struct WordAssessment: Codable {
    let word: String
    let offset: Int64
    let duration: Int64
    let confidence: Double
    let accuracyScore: Double
    let errorType: String
    
    enum CodingKeys: String, CodingKey {
        case word = "Word"
        case offset = "Offset"
        case duration = "Duration"
        case confidence = "Confidence"
        case accuracyScore = "AccuracyScore"
        case errorType = "ErrorType"
    }
}

struct WordPronunciationAssessment: Codable {
    let accuracyScore: Double
    let errorType: String?
    let feedback: ProsodyFeedback?
    
    enum CodingKeys: String, CodingKey {
        case accuracyScore = "AccuracyScore"
        case errorType = "ErrorType"
        case feedback = "Feedback"
    }
}

struct SyllableAssessment: Codable {
    let syllable: String
    let grapheme: String
    let pronunciationAssessment: SyllablePronunciationAssessment
    let offset: Int64
    let duration: Int64
    
    enum CodingKeys: String, CodingKey {
        case syllable = "Syllable"
        case grapheme = "Grapheme"
        case pronunciationAssessment = "PronunciationAssessment"
        case offset = "Offset"
        case duration = "Duration"
    }
}

struct SyllablePronunciationAssessment: Codable {
    let accuracyScore: Double
    
    enum CodingKeys: String, CodingKey {
        case accuracyScore = "AccuracyScore"
    }
}

struct PhonemeAssessment: Codable {
    let phoneme: String
    let pronunciationAssessment: PhonemePronunciationAssessment
    let offset: Int64
    let duration: Int64
    
    enum CodingKeys: String, CodingKey {
        case phoneme = "Phoneme"
        case pronunciationAssessment = "PronunciationAssessment"
        case offset = "Offset"
        case duration = "Duration"
    }
}

struct PhonemePronunciationAssessment: Codable {
    let accuracyScore: Double
    
    enum CodingKeys: String, CodingKey {
        case accuracyScore = "AccuracyScore"
    }
}

struct ProsodyFeedback: Codable {
    let prosody: ProsodyDetails
    
    enum CodingKeys: String, CodingKey {
        case prosody = "Prosody"
    }
}

struct ProsodyDetails: Codable {
    let breakDetails: BreakDetails
    let intonation: IntonationDetails
    
    enum CodingKeys: String, CodingKey {
        case breakDetails = "Break"
        case intonation = "Intonation"
    }
}

struct BreakDetails: Codable {
    let errorTypes: [String]
    let unexpectedBreak: BreakConfidence?
    let missingBreak: BreakConfidence?
    let breakLength: Int64?
    
    enum CodingKeys: String, CodingKey {
        case errorTypes = "ErrorTypes"
        case unexpectedBreak = "UnexpectedBreak"
        case missingBreak = "MissingBreak"
        case breakLength = "BreakLength"
    }
}

struct BreakConfidence: Codable {
    let confidence: Double
    
    enum CodingKeys: String, CodingKey {
        case confidence = "Confidence"
    }
}

struct IntonationDetails: Codable {
    let errorTypes: [String]
    let monotone: MonotoneDetails?
    
    enum CodingKeys: String, CodingKey {
        case errorTypes = "ErrorTypes"
        case monotone = "Monotone"
    }
}

struct MonotoneDetails: Codable {
    let syllablePitchDeltaConfidence: Double
    
    enum CodingKeys: String, CodingKey {
        case syllablePitchDeltaConfidence = "SyllablePitchDeltaConfidence"
    }
} 