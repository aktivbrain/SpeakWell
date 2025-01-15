import SwiftUI

struct TextInputView: View {
    @StateObject private var viewModel = TextToSpeechViewModel()
    @StateObject private var recordingService = RecordingService()
    @State private var showingAnalysisResults = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextEditor(text: $viewModel.inputText)
                    .frame(height: 200)
                    .padding(10)
                    .background(Color.appInteractive.opacity(0.2))
                    .cornerRadius(8)
                    .foregroundColor(.appText)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appInteractive, lineWidth: 1)
                    )
                    .padding(.horizontal)
                
                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.appError)
                        .padding(.horizontal)
                }
                
                // Text-to-Speech Button
                Button(action: {
                    if viewModel.isPlaying {
                        viewModel.stopSpeech()
                    } else {
                        viewModel.convertToSpeech()
                    }
                }) {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .appText))
                        } else {
                            Image(systemName: viewModel.isPlaying ? "stop.circle.fill" : "play.circle.fill")
                            Text(viewModel.isPlaying ? "Stop" : "Convert to Speech")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appInteractive)
                    .foregroundColor(.appText)
                    .cornerRadius(10)
                }
                .disabled(viewModel.isLoading)
                .padding(.horizontal)
                
                // Recording Button
                Button(action: {
                    if recordingService.isRecording {
                        recordingService.stopRecording()
                        // Here you would make the API call with recordingService.recordedText
                        // and show the analysis results
                        showingAnalysisResults = true
                    } else {
                        recordingService.startRecording()
                    }
                }) {
                    HStack {
                        Image(systemName: recordingService.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                        Text(recordingService.isRecording ? "Stop Recording" : "Record Your Speech")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(recordingService.isRecording ? Color.appError : Color.appHighlight)
                    .foregroundColor(.appText)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                if recordingService.isRecording {
                    Text("Recording... (Will stop after 3 seconds of silence)")
                        .foregroundColor(.appText.opacity(0.8))
                        .font(.caption)
                }
                
                Spacer()
            }
            .navigationTitle("Text to Speech")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        viewModel.stopSpeech()
                        recordingService.stopRecording()
                        dismiss()
                    }
                    .foregroundColor(.appText)
                }
            }
            .background(Color.appBackground)
            .sheet(isPresented: $showingAnalysisResults) {
                // This is a placeholder - you would replace these values with actual API response
                AnalysisResultsView(
                    scores: PronunciationScore(
                        accuracy: 0.85,
                        fluency: 0.78,
                        completeness: 0.92,
                        overall: 0.85
                    ),
                    feedback: "Good pronunciation overall. Pay attention to the rhythm and stress patterns.",
                    recordedText: recordingService.recordedText
                )
            }
        }
    }
} 