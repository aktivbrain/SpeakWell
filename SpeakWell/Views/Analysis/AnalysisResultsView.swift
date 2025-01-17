import SwiftUI

struct AnalysisResultsView: View {
    let result: PronunciationAssessmentResult
    
    private var firstResult: NBestResult {
        result.nbest?.first ?? NBestResult(
            confidence: 0,
            lexical: "",
            itn: nil,
            maskedITN: nil,
            display: nil,
            accuracyScore: 0,
            fluencyScore: 0,
            completenessScore: 0,
            pronScore: 0,
            words: []
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                RecordedSpeechView(
                    displayText: result.displayText,
                    snr: result.snr
                )
                
                OverallScoreView(score: firstResult.pronScore)
                
                DetailedScoresView(
                    accuracyScore: firstResult.accuracyScore,
                    fluencyScore: firstResult.fluencyScore,
                    completenessScore: firstResult.completenessScore
                )
                
                if let words = firstResult.words {
                    WordAnalysisView(words: words)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Pronunciation Analysis")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            print("📊 AnalysisResultsView appeared")
            print("Recognition Status: \(result.recognitionStatus)")
            print("Display Text: \(result.displayText)")
            print("SNR: \(result.snr) dB")
            print("NBest count: \(result.nbest?.count ?? 0)")
            print("First result confidence: \(firstResult.confidence)")
            print("First result pronScore: \(firstResult.pronScore)")
            print("Words count: \(firstResult.words?.count ?? 0)")
        }
    }
}

#Preview {
    NavigationView {
        AnalysisResultsView(
            result: PronunciationAssessmentResult(
                recognitionStatus: "Success",
                offset: 33700000,
                duration: 12200000,
                displayText: "Hello.",
                snr: 14.755138,
                nbest: [
                    NBestResult(
                        confidence: 0.9245627,
                        lexical: "hello",
                        itn: nil,
                        maskedITN: nil,
                        display: "Hello.",
                        accuracyScore: 57.0,
                        fluencyScore: 0.0,
                        completenessScore: 0.0,
                        pronScore: 11.4,
                        words: [
                            WordAssessment(
                                word: "Hello",
                                offset: 33700000,
                                duration: 12200000,
                                confidence: 0.0,
                                accuracyScore: 57.0,
                                errorType: "Mispronunciation"
                            )
                        ]
                    )
                ]
            )
        )
    }
} 