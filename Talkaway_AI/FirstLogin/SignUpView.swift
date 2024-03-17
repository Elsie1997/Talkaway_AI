//
//  SignUpView.swift
//  Talkaway_AI
//
//  Created by Elsie Hsu on 9/11/23.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        VStack{
            Text("行前準備！").font(.system(size: 25))
            Text("第一步").font(.system(size: 25))
            Spacer().frame(height: 75)
            Text("馬上註冊獲得專屬學習計畫，\n並記錄每次學習進度。").font(.system(size: 25)).multilineTextAlignment(.center)
            Spacer().frame(height: 75)
            //Avatar
            
            Button {} label: {
                HStack {Image("google").resizable().frame(width: 30, height: 28)
                    Text("使用Google註冊    ").font(.system(size:18))}
            }
            .buttonStyle(.borderedProminent).controlSize(.large)
            Button {} label: {
                HStack {Image("facebook").resizable().frame(width: 30, height: 28)
                    Text("使用Facebook註冊").font(.system(size:18))}
            }
            .buttonStyle(.borderedProminent).controlSize(.large)
            Button {} label: {
                HStack {Image(systemName: "applelogo").resizable().frame(width: 23, height: 28)
                    Text("使用Apple註冊         ").font(.system(size:18))}
            }
            .buttonStyle(.borderedProminent).controlSize(.large)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color(hex:0xE4C8DE))
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}



