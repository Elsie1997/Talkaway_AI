//
//  TextHistoryModelView.swift
//  Talkaway_AI
//
//  Created by 陳冠霖 on 2023/10/22.
//

import SwiftUI

struct TextHistoryModalView: View {
    var recentMessage: Message?
    @Binding var showTextHistory: Bool

    var body: some View {
        VStack {
            Text("Text History")
                .font(.headline)
                .padding()

            if let message = recentMessage {
                VStack(alignment: .leading) {
                    Text("Request:")
                        .font(.subheadline)
                        .padding(.bottom, 5)

                    Text(message.text)
                        .font(.body)
                        .padding(.bottom, 10)

                    // Assuming the next message in the array is the response.
                    // (This might not be the case in a real-world scenario,
                    // but for the sake of this example, I'm making this assumption.)
                    Text("Response:")
                        .font(.subheadline)
                        .padding(.bottom, 5)

                    // Here, you can display the response.
                    // For now, I'll just display a placeholder.
                    Text("Fake Response now....")
                        .font(.body)
                }
            }

            Button(action: {
                showTextHistory = false
            }) {
                Text("Back")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, maxHeight: UIScreen.main.bounds.height * 0.4)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}
