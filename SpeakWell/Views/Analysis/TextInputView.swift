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
                    Task {
                        if recordingService.isRecording {
                            await recordingService.stopRecording()
                            await MainActor.run {
                                showingAnalysisResults = true
                            }
                        } else {
                            await MainActor.run {
                                recordingService.startRecording()
                            }
                        }
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
                        Task {
                            if recordingService.isRecording {
                                await recordingService.stopRecording()
                            }
                            viewModel.stopSpeech()
                            dismiss()
                        }
                    }
                    .foregroundColor(.appText)
                }
            }
            .onDisappear {
                Task {
                    if recordingService.isRecording {
                        await recordingService.stopRecording()
                    }
                }
            }
            .background(Color.appBackground)
            .sheet(isPresented: $showingAnalysisResults) {
                if let result = recordingService.assessmentResult {
                    NavigationView {
                        AnalysisResultsView(result: result)
                    }
                }
            }
        }
    }
} 