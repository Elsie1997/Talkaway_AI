//
//  ChatView.swift
//  Talkaway_AI
//
//  Created by 陳冠霖 on 2023/9/29.
//

import SwiftUI


struct ChooseChatView: View {
    var selectedChatScenario: ChatScenario
    
    @State private var selectedLevel = "初級"
    @State private var selectedGender = "男"
    @State private var randomContent: String? = nil
    
    let levels = ["初級", "中級", "高級"]
    let genders = ["男", "女"]
    
    var body: some View {
        VStack{
            // 選擇 難度 && 性別
            HStack{
                Text("難度")
                    .bold(true)
                    .font(.system(size: 18))
                
                Picker(selection: $selectedLevel, label: Text("難度")) {
                    ForEach(levels, id: \.self) { level in
                        Text(level).tag(level)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 200)
                .padding(.leading, 10)
            }
            
            HStack{
                Text("性別")
                    .bold(true)
                    .font(.system(size: 18))
                
                Picker(selection: $selectedGender, label: Text("性別")) {
                    ForEach(genders, id: \.self) { gender in
                        Text(gender).tag(gender)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 200)
                .padding(.leading, 10)
            }
           
            // 顯示情境內容
            Text(randomContent ?? "--")
                .frame(width: 200)
                .padding(.top, 50)
                .foregroundColor(Color.gray)
            
            // 開始談話按鈕
            NavigationLink(destination: CheatingView()) {
                Text("開始談話")
                    .font(.headline)
                    .frame(width: 200, height: 14)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding(.top, 50)
        }
        .onAppear {
            if randomContent == nil && !selectedChatScenario.content.isEmpty {
                randomContent = selectedChatScenario.content.randomElement()
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        //randomElement()返回的是Optional，必須提供一個默認值 或 unwrap它。
        let previewScenario = ChatScenarioViewModel().scenarios.randomElement() ?? ChatScenario(topic: "--", iconName: "questionmark", content: ["--"])
        
        ChooseChatView(selectedChatScenario: previewScenario)
    }
}
