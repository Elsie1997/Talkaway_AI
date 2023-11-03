//
//  FeedbackView.swift
//  Talkaway_AI
//
//  Created by Elsie Hsu on 10/29/23.
//

import SwiftUI
import Foundation

struct FeedbackView: View {
    @State private var progress: Double = 0.0
    @State private var scaleEffect: CGFloat = 1.0
    
    var body: some View {
        ZStack(alignment: .leading) {
            let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            
            ZStack{
                VStack {
                    ProgressBarView(progress: $progress)
                        .onReceive(timer) { _ in
                            if progress < 1.0 {
                                progress += 1.0 / (1.0 * 10.0)
                            }
                        }
                }
            }
        }
    }
}
                        
struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
