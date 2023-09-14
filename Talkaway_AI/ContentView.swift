//
//  ContentView.swift
//  Talkaway_AI
//
//  Created by Elsie Hsu on 9/10/23.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image("logo").resizable().frame(width: 180, height: 180)
            //Spacer().frame(height: 10)
            Text("Talkaway").font(.system(size: 50,weight: .bold)).foregroundStyle(.white)
            Spacer().frame(height: 25)
            
            VStack{
                Text("隨時隨地,在您身邊。")
                Text("Beside you, anytime, anywhere.")
            }.font(.system(size: 21)).foregroundStyle(.white)
            Spacer().frame(height: 100)
            
            //Button
            NavigationLink{SignUpView()}
            label: {
                Text("啟動旅程                   ").padding().background(Color(hex:0x0096FF)).font(.system(size:26.5, weight: .bold)).foregroundStyle(.white)
            }.clipShape(Capsule()).controlSize(.large)
            NavigationLink(destination: LogInView()) {
                Text("我已經有Talkaway帳號").font(.system(size:21)).foregroundStyle(.white)
                }
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color(hex:0xCC00CC))
        }
    
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
    }




