//
//  TimeBarView.swift
//  Talkaway_AI
//
//  Created by Elsie Hsu on 11/2/23.
//

import SwiftUI
import Foundation

struct ProgressBarView: View {
    @Binding var progress: Double
    @State private var scaleEffect: CGFloat = 1.0

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
                .foregroundColor(progress >= 1.0 ? Color.yellow : Color.blue)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(progress >= 1.0 ? Color.white : Color.clear, lineWidth: 8) // Increased border width
                )
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
        .scaleEffect(scaleEffect)
        .onTapGesture {
            if progress >= 1.0 {
                print("Progress bar tapped!")
                withAnimation(.easeInOut(duration: 0.1)) {
                    scaleEffect = 0.9
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.5)) {
                        scaleEffect = 1.0
                    }
                }
            }
        }
    }
}
