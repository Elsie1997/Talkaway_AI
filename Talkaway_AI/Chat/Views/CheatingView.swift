//
//  CheatingView.swift
//  Talkaway_AI
//
//  Created by 陳冠霖 on 2023/10/2.
//

import SwiftUI
import Speech
import AVFoundation

struct CheatingView: View {
    @StateObject private var audioManager = AudioManager()
    
    @State private var isRecording = false
    @State private var showMessageDetail = false
    @State private var messages: [Message] = []
    @State private var speechRecognizer = SpeechRecognizer() 
    @State private var currentlyPlayingMessageID: UUID? = nil
    @State private var selectedMessage: Message? = nil
    
    // 進度條
    @State private var progress: Double = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Google TTS
    let ttsManager = GoogleTTSManager()
    
    
    var body: some View {
        ZStack{
            VStack {
                ProgressBarView(progress: $progress)
                    .onReceive(timer) { _ in
                        if progress < 1.0 {
                            progress += 1.0 / (1.0 * 10.0) // 三分鐘
                        }
                    }
                
                // 顯示語音文字
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: true) {
                        VStack(spacing: 10) {
                            ForEach(messages.filter { !$0.text.isEmpty }, id: \.id) { message in
                                // Display your message bubbles here
                                if message.isFromUser {
                                    userMessageBubble(message: message)
                                } else {
                                    apiMessageBubble(message: message)
                                }
                            }
                        }
                    }
                    .onChange(of: messages) { _ in
                        withAnimation {
                            if let lastMessage = messages.last {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                Button(action: toggleRecording) {
                    Image(systemName: isRecording ? "checkmark.circle" : "mic.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
            .modifier(BlurredBackground(isShown: showMessageDetail))
            
            // Pop-up window
            if showMessageDetail, let messageToShow = selectedMessage {
                PopupMessageView(message: messageToShow, isShown: $showMessageDetail)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex:0xE4C8DE))
    }
        
    
    @ViewBuilder
    func userMessageBubble(message: Message) -> some View {
        HStack {
            Spacer()
            ZStack {
                ChatBubbleShape(direction: .right, hasAudio: message.hasAudio)
                    .fill(Color.blue)
                    .frame(width: 90, height: 60) // Adjust the width to accommodate both icons
                
                HStack(spacing: 10) {
                    // Playback Button
                    Button(action: {
                        if message.hasAudio {
                            handleAudioPlayback(message: message)
                        }
                    }) {
                        if message.hasAudio {
                            Image(systemName: (audioManager.isPlaying && currentlyPlayingMessageID == message.id) ? "stop.circle.fill" : "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                    }
                    
                    // Book Icon - to show message in a model
                    Button(action: {
                        selectedMessage = message
                        showMessageDetail = true
                    }) {
                        Image(systemName: "a.book.closed.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                    }
                }
            }
            
        }
        .padding(.trailing, 8)  // Adjust this padding for the tail position
    }
    
    func handleAudioPlayback(message: Message) {
        guard let audioURL = message.audioURL else { return }
        
        if audioManager.isPlaying && currentlyPlayingMessageID == message.id {
            audioManager.stopPlaying()
            currentlyPlayingMessageID = nil
        } else {
            audioManager.playAudio(url: audioURL)
            currentlyPlayingMessageID = message.id
        }
    }
    
    @ViewBuilder
    func apiMessageBubble(message: Message) -> some View {
        HStack {
            ZStack {
                ChatBubbleShape(direction: .left, hasAudio: message.hasAudio)
                    .fill(Color.gray)
                    .frame(width: 90, height: 60) // Adjust the width to accommodate both icons
                
                HStack(spacing: 10) {
                    if message.hasAudio {
                        Button(action: {
                            handleAudioPlayback(message: message)
                        }) {
                            Image(systemName: (audioManager.isPlaying && currentlyPlayingMessageID == message.id) ? "stop.circle.fill" : "play.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                    }

                    // Always display the book button
                    Button(action: {
                        selectedMessage = message
                        showMessageDetail = true
                    }) {
                        Image(systemName: "a.book.closed.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                    }
                }
                .background(Color.gray)
                .cornerRadius(10)

            }
            Spacer()
        }
        .padding(.leading, 8)  // Adjust this padding for the tail position
    }


    func toggleRecording() {
        isRecording.toggle()
        if isRecording {
            audioManager.startRecording()
            
            Task {
                speechRecognizer.startTranscribing()
            }
        } else {
            audioManager.stopRecording()
            
            Task {
                _ = try? await Task.sleep(nanoseconds: UInt64(0.5 * Double(NSEC_PER_SEC)))  // 延遲 0.5 秒
                speechRecognizer.stopTranscribing()
                
                addMessage(from: speechRecognizer.transcript, isFromUser: true)
                addMessage(from: "Fake Response now!", isFromUser: false)
            }
        }
    }
        
    func addMessage(from transcript: String, isFromUser: Bool) {
        if !isFromUser {  // If the message is from API
            convertTextToAudio(text: transcript) { audioURL in
                let hasAudioContent = (audioURL != nil)
                let newMessage = Message(text: transcript, isFromUser: isFromUser, audioURL: audioURL, hasAudio: hasAudioContent)
                messages.append(newMessage)
            }
        } else {
            let newMessage = Message(text: transcript, isFromUser: isFromUser, audioURL: audioManager.audioURL, hasAudio: true)
            messages.append(newMessage)
        }
    }
    
    func convertTextToAudio(text: String, completion: @escaping (URL?) -> Void) {
        ttsManager.fetchGoogleTTS(text: text) { audioData in
            guard let data = audioData else {
                completion(nil)
                return
            }
            
            // Decide where to save the audio
            let localURL = audioManager.getDocumentsDirectory().appendingPathComponent("\(UUID().uuidString).mp3")
            
            // Save the audio locally
            do {
                try data.write(to: localURL)
                completion(localURL)
            } catch {
                print("Error saving audio data: \(error)")
                completion(nil)
            }
        }
    }
}
       
struct BlurredBackground: ViewModifier {
    var isShown: Bool

    func body(content: Content) -> some View {
        content
            .blur(radius: isShown ? 5 : 0)
            .disabled(isShown)
    }
}


struct CheatingView_Previews: PreviewProvider {
    static var previews: some View {
        CheatingView()
    }
}
