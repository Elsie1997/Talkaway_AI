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
        GeometryReader { geometry in
            VStack(spacing: 20) {
                ScrollView {
                    Text(message.text)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                
                Button("Back") {
                    isShown = false
                }
                .padding()
            }
            .frame(width: min(geometry.size.width, 250), height: min(geometry.size.height, 400))
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
