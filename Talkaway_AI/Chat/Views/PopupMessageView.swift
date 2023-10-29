//
//  PopupMessageView.swift
//  Talkaway_AI
//
//  Created by 陳冠霖 on 2023/10/22.
//

import SwiftUI

struct PopupMessageView: View {
    let message: Message
    @Binding var isShown: Bool

    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                Text(message.text)
                    .padding()
            }
            
            Button("Back") {
                isShown = false
            }
            .padding()
        }
        .frame(width: 250, height: 150)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}
