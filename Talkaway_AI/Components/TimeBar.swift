//
//  TimeBar.swift
//  Talkaway_AI
//
//  Created by 陳冠霖 on 2023/10/10.
//

import SwiftUI
import Foundation

struct ProgressBarView: View {
    @Binding var progress: Double
    @State private var isPressed: Bool = false

    var body: some View {
        ZStack(alignment: .leading) {
            // Background bar
            Rectangle()
                .frame(width: UIScreen.main.bounds.width * 0.65, height: 30)
                .foregroundColor(Color(hex: 0xADD8E6))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3) // Shadow for 3D effect

            // Progress bar
            Rectangle()
                .frame(width: max(CGFloat(self.progress) * (UIScreen.main.bounds.width * 0.65), 0), height: 30)
                .foregroundColor(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3) // Shadow for 3D effect

            // Text "獲得時數"
            HStack {
                Spacer()
                Text("獲得時數")
                    .font(.system(size: 14))
                    .bold(true)
                    .foregroundColor(.black)
                Spacer()
            }                
        }
        .frame(width: UIScreen.main.bounds.width * 0.65)
        .scaleEffect(isPressed ? 0.97 : 1.0) // Pressed effect
        .onTapGesture {
            if progress >= 1.0 {
                print("ProgressBar tapped!")
                isPressed.toggle() // Toggles pressed effect on and off
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed.toggle()
                }
            }
        }
    }
}
