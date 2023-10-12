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
    @State private var isRecording = false
    @State private var messages: [Message] = []
    @State private var speechRecognizer = SpeechRecognizer()
    
    @State private var progress: Double = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 0) {
            ProgressBarView(progress: $progress)
                .onReceive(timer) { _ in
                    if progress < 1.0 {
                        progress += 1.0 / (1.0 * 10.0) // 三分鐘
                    }
                }
                .padding(.bottom, 280)
            
            // 顯示語音文字
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(messages.filter { !$0.text.isEmpty }, id: \.id) { message in
                        HStack {
                            Spacer()
                            MessageView(message: message)
                        }
                    }
                }
            }
            
            Spacer() // 把麥克風按鈕推到最下面
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
        .alignmentGuide(.top, computeValue: { d in d[.top] })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex:0xE4C8DE))
    }
    
    func toggleRecording() {
        isRecording.toggle()
        if isRecording {
            Task {
                await speechRecognizer.startTranscribing()
            }
        } else {
            Task {
                await speechRecognizer.stopTranscribing()
                await addMessage(from: speechRecognizer.transcript)
            }
        }
    }
    
    func addMessage(from transcript: String) {
        let newMessage = Message(text: transcript)
        messages.append(newMessage)
    }
}
        
    
struct CheatingView_Previews: PreviewProvider {
    static var previews: some View {
        CheatingView()
    }
}
