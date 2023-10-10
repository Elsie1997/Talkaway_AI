//
//  TimeBar.swift
//  Talkaway_AI
//
//  Created by 陳冠霖 on 2023/10/10.
//

import SwiftUI
import Foundation

struct ProgressBarView: View {
    var progress: Double // 0.0 -> 1.0
    
    var body: some View {
        VStack(spacing: 5) {
            Text("獲得時數")
                .foregroundColor(Color.black)
                .bold(true)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.65, height: 10) // 修改這裡的寬度
                    .opacity(0.3)
                    .foregroundColor(Color.blue)
                    .cornerRadius(8)
                
                Rectangle()
                    .frame(width: CGFloat(self.progress) * (UIScreen.main.bounds.width * 0.65), height: 10) // 修改這裡的寬度
                    .foregroundColor(Color.blue)
                    .animation(.linear(duration: 0.2), value: progress)
                    .cornerRadius(8)
                
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.blue)
                    .offset(x: CGFloat(self.progress) * (UIScreen.main.bounds.width * 0.65) - 7.5)
            }
        }
    }
}
