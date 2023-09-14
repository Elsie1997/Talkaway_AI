//
//  LogInView.swift
//  Talkaway_AI
//
//  Created by Elsie Hsu on 9/11/23.
//

import SwiftUI

struct LogInView: View {
    var body: some View {
        VStack{
            Text("歡迎回來！").font(.system(size: 35))
            Spacer().frame(height: 250)
            //Avatar
            Button {} label: {
                HStack {Image("google").resizable().frame(width: 30, height: 28)
                    Text("使用Google登入    ").font(.system(size:20))}
            }
            .buttonStyle(.borderedProminent).controlSize(.large)
            Button {} label: {
                HStack {Image("facebook").resizable().frame(width: 30, height: 28)
                    Text("使用Facebook登入").font(.system(size:20))}
            }
            .buttonStyle(.borderedProminent).controlSize(.large)
            Button {} label: {
                HStack {Image(systemName: "applelogo").resizable().frame(width: 23, height: 28)
                    Text("使用Apple登入         ").font(.system(size:20))}
            }
            .buttonStyle(.borderedProminent).controlSize(.large)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color(hex:0xCA5CDD))
    }
}

//CA5CDD

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
