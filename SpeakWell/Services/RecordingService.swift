import AVFoundation
import Speech
import AVFAudio

class RecordingService: NSObject, ObservableObject {
    private var audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var silenceTimer: Timer?
    private var audioData: Data?
    private let azureService = AzureSpeechService()
    @Published var assessmentResult: PronunciationAssessmentResult?
    
    @Published var isRecording = false
    @Published var recordedText = ""
    @Published var error: String?
    
    override init() {
        super.init()
        requestPermissions()
    }
    
    private func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    break
                default:
                    self.error = "Speech recognition authorization denied"
                }
            }
        }
        
        // Handle microphone permission for different iOS versions
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if !granted {
                        self.error = "Microphone permission denied"
                    }
                }
            }
        } else {
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if !granted {
                        self.error = "Microphone permission denied"
                    }
                }
            }
        }
    }
    
    func startRecording() {
        resetSilenceTimer()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            let inputNode = audioEngine.inputNode
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            recognitionRequest?.shouldReportPartialResults = true
            
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest!) { [weak self] result, error in
                guard let self = self else { return }
                if let result = result {
                    self.recordedText = result.bestTranscription.formattedString
                    self.resetSilenceTimer()
                }
            }
            
            // Use the input node's native format
            let nativeFormat = inputNode.outputFormat(forBus: 0)
            print("🎙 Starting recording with native format: \(nativeFormat.description)")
            
            // Reset audio data when starting new recording
            self.audioData = Data()
            
            // Install tap with native format
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: nativeFormat) { [weak self] buffer, _ in
                guard let self = self else { return }
                self.recognitionRequest?.append(buffer)
                
                // Debug print for buffer
                print("📼 Received buffer with \(buffer.frameLength) frames")
                
                // Convert float buffer to int16 PCM
                let frameCount = AVAudioFrameCount(buffer.frameLength)
                
                // Create int16 buffer
                let int16Format = AVAudioFormat(
                    commonFormat: .pcmFormatInt16,
                    sampleRate: 16000,
                    channels: 1,
                    interleaved: true
                )!
                
                guard let converter = AVAudioConverter(from: buffer.format, to: int16Format),
                      let convertedBuffer = AVAudioPCMBuffer(
                        pcmFormat: int16Format,
                        frameCapacity: frameCount
                      ) else {
                    print("⚠️ Couldn't create converter or buffer")
                    return
                }
                
                var error: NSError?
                let inputBlock: AVAudioConverterInputBlock = { inNumPackets, outStatus in
                    outStatus.pointee = .haveData
                    return buffer
                }
                
                converter.convert(to: convertedBuffer, error: &error, withInputFrom: inputBlock)
                
                if let error = error {
                    print("⚠️ Conversion error: \(error)")
                    return
                }
                
                // Get the converted data
                guard let channelData = convertedBuffer.int16ChannelData else {
                    print("⚠️ No channel data available")
                    return
                }
                
                let byteCount = Int(convertedBuffer.frameLength * 2) // 2 bytes per sample for int16
                let data = Data(bytes: channelData[0], count: byteCount)
                print("📊 Captured \(data.count) bytes of audio data")
                
                // Append to existing audio data
                self.audioData?.append(data)
                print("📈 Total audio data size: \(self.audioData?.count ?? 0) bytes")
                
                self.resetSilenceTimer()
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            isRecording = true
            
        } catch {
            self.error = "Recording failed to start: \(error.localizedDescription)"
            print("❌ Recording error: \(error)")
        }
    }
    
    private func resetSilenceTimer() {
        silenceTimer?.invalidate()
        silenceTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            Task { @MainActor in
                await self?.stopRecording()
            }
        }
    }
    
    @MainActor
    func stopRecording() async {
        // Guard against multiple stops
        guard isRecording else { return }
        
        print("🎤 Stopping recording...")
        print("📝 Recorded text: \(recordedText)")
        
        // First, stop collecting new audio
        isRecording = false
        silenceTimer?.invalidate()
        silenceTimer = nil
        
        // Safely clean up audio resources
        do {
            // Stop engine if running
            if audioEngine.isRunning {
                // First stop recognition task
                recognitionTask?.cancel()
                recognitionTask = nil
                
                // End audio request
                recognitionRequest?.endAudio()
                recognitionRequest = nil
                
                // Stop engine
                audioEngine.stop()
                try await Task.sleep(nanoseconds: 100_000_000) // Small delay to ensure clean stop
                
                // Remove tap after stopping engine
                audioEngine.inputNode.removeTap(onBus: 0)
                
                // Deactivate audio session last
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setActive(false, options: [.notifyOthersOnDeactivation])
                try await Task.sleep(nanoseconds: 100_000_000) // Additional delay after session deactivation
            }
        } catch {
            print("❌ Error stopping recording: \(error)")
            self.error = "Error stopping recording: \(error.localizedDescription)"
            return
        }
        
        // After stopping recording, send to Azure for analysis
        guard !recordedText.isEmpty else {
            print("⚠️ No text was recorded")
            self.error = "No text was recorded"
            return
        }
        
        guard let audioData = self.audioData else {
            print("⚠️ No audio data captured")
            self.error = "No audio data captured"
            return
        }
        
        print("🎵 Raw audio data size: \(audioData.count) bytes")
        
        // Create WAV header
        var wavData = Data()
        wavData.appendWAVHeader(
            sampleRate: 16000,
            bitDepth: 16,
            channels: 1,
            dataSize: UInt32(audioData.count)
        )
        
        // Append audio data after header
        wavData.append(audioData)
        
        print("🎵 WAV file size: \(wavData.count) bytes")
        
        do {
            // Clear any previous errors
            self.error = nil
            
            print("📤 Sending to Azure for analysis...")
            let result = try await azureService.assessPronunciation(
                audioData: audioData,
                referenceText: recordedText
            )
            
            print("📥 Received analysis result:")
            print("- Recognition status: \(result.recognitionStatus)")
            print("- Display text: \(result.displayText)")
            
            if let firstResult = result.nbest?.first {
                print("- Confidence: \(firstResult.confidence)")
                print("- Pronunciation assessment:")
                print("  - Pronunciation Score: \(firstResult.pronScore)")
                print("  - Accuracy Score: \(firstResult.accuracyScore)")
                print("  - Fluency Score: \(firstResult.fluencyScore)")
                print("  - Completeness Score: \(firstResult.completenessScore)")
                
                // Set the result since we have valid scores
                self.assessmentResult = result
            } else {
                print("⚠️ No detailed assessment results available")
                self.error = "No detailed assessment results available"
            }
            
        } catch {
            print("❌ Analysis error: \(error)")
            self.error = "Analysis failed: \(error.localizedDescription)"
        }
    }
}

// Add helper extension for WAV header
extension Data {
    mutating func appendWAVHeader(sampleRate: Int = 16000, bitDepth: Int = 16, channels: Int = 1, dataSize: UInt32) {
        let formatChunkSize: UInt32 = 16
        let formatType: UInt16 = 1 // PCM
        let bytesPerSample = UInt16(bitDepth / 8)
        let blockAlign = channels * Int(bytesPerSample)
        let byteRate = sampleRate * blockAlign
        
        // RIFF header
        append("RIFF".data(using: .ascii)!) // ChunkID
        append(withUInt32: UInt32(dataSize + 36)) // ChunkSize: 36 + SubChunk2Size
        append("WAVE".data(using: .ascii)!) // Format
        
        // fmt sub-chunk
        append("fmt ".data(using: .ascii)!) // Subchunk1ID
        append(withUInt32: formatChunkSize) // Subchunk1Size
        append(withUInt16: formatType) // AudioFormat
        append(withUInt16: UInt16(channels)) // NumChannels
        append(withUInt32: UInt32(sampleRate)) // SampleRate
        append(withUInt32: UInt32(byteRate)) // ByteRate
        append(withUInt16: UInt16(blockAlign)) // BlockAlign
        append(withUInt16: UInt16(bitDepth)) // BitsPerSample
        
        // data sub-chunk
        append("data".data(using: .ascii)!) // Subchunk2ID
        append(withUInt32: dataSize) // Subchunk2Size
    }
    
    private mutating func append(withUInt32 value: UInt32) {
        var value = value.littleEndian // WAV files use little-endian
        append(Data(bytes: &value, count: 4))
    }
    
    private mutating func append(withUInt16 value: UInt16) {
        var value = value.littleEndian // WAV files use little-endian
        append(Data(bytes: &value, count: 2))
    }
} 