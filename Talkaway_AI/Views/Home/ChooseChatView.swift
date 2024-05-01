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
    @State private var selectedAccent = "美"
    @State private var selectedSpeed = "0.5"
    @State private var randomContent: String? = nil
    @State private var isShowAdvanced: Bool = false
    
    let levels = ["初級", "中級", "高級"]
    let genders = ["男", "女"]
    let accent = ["美", "英", "澳"]
    let speed = ["0.5", "0.75", "1", "1.25","1.5"]
    let time = ["5", "10", "15", "20"]
    
    var body: some View {
        ZStack{
            HStack{
                Text("目標時間：")
                    .bold(true)
                    .font(.system(size: 18))
                    .padding(.trailing, 10)
                
                Section{
                    Picker(selection: $selectedSpeed, label: Text("目標時間：")) {
                        ForEach(time, id: \.self) { level in
                            Text(level).tag(level)
                        }
                    }
                    .frame(width: 100)
                    .padding(.leading, 10)
                    .background(Color.white)
                    .cornerRadius(10)
                }
                Text("分鐘")
                    .bold(true)
                    .font(.system(size: 18))
                    .padding(.trailing, 10)
            }.offset(y: -320)
            
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
                
                
                Button("進階設定"){
                    isShowAdvanced.toggle()
                }.padding(10)
                
                if isShowAdvanced {
                    // 選擇 性別 & 口音 & 語速
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
                        
                    }.padding(.bottom, 20)
                    
                    HStack{
                        Text("口音")
                            .bold(true)
                            .font(.system(size: 18))
                        
                        Picker(selection: $selectedAccent, label: Text("口音")) {
                            ForEach(accent, id: \.self) { level in
                                Text(level).tag(level)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 200)
                        .padding(.leading, 10)
                        
                    }.padding(.bottom, 20)
                    
                    HStack{
                        Text("語速")
                            .bold(true)
                            .font(.system(size: 18))
                            .padding(.trailing, 10)
                        
                        Section{
                            Picker(selection: $selectedSpeed, label: Text("語速")) {
                                ForEach(speed, id: \.self) { level in
                                    Text("X\(level)").tag(level)
                                }
                            }
                            .frame(width: 190)
                            .padding(.leading, 10)
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        
                    }
                }
                
                // 顯示情境內容
                Text(randomContent ?? "--")
                    .frame(width: 200)
                    .padding(.top, 50)
                    .foregroundColor(Color(hex: 0x333333))
                
                // 開始談話按鈕
                NavigationLink(destination: CheatingView(content: randomContent)) {
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
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex:0xE4C8DE))
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
