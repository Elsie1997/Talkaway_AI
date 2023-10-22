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
    @State private var showTextHistory = false
    @State private var messages: [Message] = []
    @State private var selectedMessage: Message?
    @State private var speechRecognizer = SpeechRecognizer()
    @State private var showMessageText = false
    
    // 進度條
    @State private var progress: Double = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
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
                Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex:0xE4C8DE))
    }
        
    
    @ViewBuilder
    func userMessageBubble(message: Message) -> some View {
        HStack {
            Spacer()
            NavigationLink(destination: MessageView(message: message)) {
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
                                Image(systemName: audioManager.isPlaying ? "stop.circle.fill" : "play.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        // Book Icon
                        Image(systemName: "book.fill")
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
        
        if audioManager.isPlaying {
            audioManager.stopPlaying()
        } else {
            audioManager.playAudio(url: audioURL)
        }
    }
    
    @ViewBuilder
    func apiMessageBubble(message: Message) -> some View {
        HStack {
            NavigationLink(destination: MessageView(message: message)) {
                ZStack {
                    ChatBubbleShape(direction: .left, hasAudio: message.hasAudio)
                        .fill(Color.gray)
                        .frame(width: 60, height: 60)
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                }
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
                addMessage(from: "Fake Response now....", isFromUser: false)
            }
        }
    }
        
    func addMessage(from transcript: String, isFromUser: Bool) {
        let hasAudioContent = (audioManager.audioURL != nil)
        let newMessage = Message(text: transcript, isFromUser: isFromUser, audioURL: audioManager.audioURL, hasAudio: hasAudioContent)
        messages.append(newMessage)
    }
}
       
    
struct CheatingView_Previews: PreviewProvider {
    static var previews: some View {
        CheatingView()
    }
}
