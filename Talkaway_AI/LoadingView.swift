//
//  LoadingView.swift
//  Talkaway_AI
//
//  Created by Elsie Hsu on 9/26/23.
//

import SwiftUI

struct LoadingView: View {
    @State private var scale: CGFloat = 0.1
    var body: some View {
        VStack {
            Image("logo").resizable().frame(width: 200, height: 200)
            Spacer().frame(height: 55)
            Text("提升口說的要訣就是勤加練習").font(.system(size: 23)).foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex:0xCC00CC)).scaleEffect(scale)
                .onAppear {
                        withAnimation(.spring()) {
                            scale = 1.0
                        }
                }
                
            }
    }
    
    struct LoadingView_Previews: PreviewProvider {
        static var previews: some View {
            LoadingView()
        }
    }

