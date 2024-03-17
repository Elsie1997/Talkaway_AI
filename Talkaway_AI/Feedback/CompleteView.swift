//
//  CompleteView.swift
//  Talkaway_AI
//
//  Created by Elsie Hsu on 1/7/24.
//

import SwiftUI
import Foundation

struct CompleteView: View {
    @State private var progress: Double = 0.0
    @State private var scaleEffect: CGFloat = 1.0
    
    var body: some View {
        NavigationView{
            VStack{
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
                
                //.position(x: 200, y: 50)
                
                
                HStack{
                    Text("上一句是").font(.system(size: 20))
                    Image(systemName: "speaker.wave.3.fill")
                }.position(x: 70, y: 80)
                
                HStack{
                    Text("你剛剛這樣說").font(.system(size: 20)).bold()
                    Image(systemName: "speaker.wave.3.fill")
                }.position(x: 90, y: 50)
                
                Divider().frame(width:300,height:0.5).background(Color.black)
                
                HStack{
                    Text("需要做一些修正").font(.system(size: 20)).bold()
                    Image(systemName: "speaker.wave.3.fill")
                }.position(x: 100, y: 20)
                
                Divider().frame(width:300,height:0.5).background(Color.black)
                
                HStack{
                    Text("這樣講更道地").font(.system(size: 20)).bold()
                    Image(systemName: "speaker.wave.3.fill")
                }.position(x: 90, y: 20)
                
                NavigationLink(destination: HomeView()) {
                    Text("完成").font(.system(size:20)).bold().foregroundStyle(.blue)
                }
                
                //HStack{
                //Text("/").font(.system(size: 20)).bold().foregroundStyle(.black)
                //}.position(x: 50, y: -10)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading).background(Color(hex:0xE4C8DE))
        }
    }
}


struct CompleteView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteView()
    }
}
