//
//  File.swift
//  Talkaway_AI
//
//  Created by ANJU NI on 2024/4/11.
//

import SwiftUI



struct SettingView: View {
    var selectedChatScenario: ChatScenario
    
    @State private var selectedGender = "男"
    @State private var selectedAccent = "美"
    @State private var selectedSpeed = "0.5"
    @State private var randomContent: String? = nil
    @State private var isShowAdvanced: Bool = false
    
    let genders = ["男", "女"]
    let accent = ["美", "英", "澳"]
    let speed = ["0.5", "0.75", "1", "1.25","1.5"]
    
    var body: some View {
       
        
        ZStack{
            // 顯示情境內容
         
            Text(randomContent ?? "--")
                .frame(width: 200)
                .foregroundColor(Color(hex: 0x333333))
                .offset(y: -250)
            
            

            VStack{
                Button("進階設定"){
                    isShowAdvanced.toggle()
                }
                
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

struct SettingViewPreviews: PreviewProvider {
    static var previews: some View {
        //randomElement()返回的是Optional，必須提供一個默認值 或 unwrap它。
        let previewScenario = ChatScenarioViewModel().scenarios.randomElement() ?? ChatScenario(topic: "--", iconName: "questionmark", content: ["--"])
        
        SettingView(selectedChatScenario: previewScenario)
    }
}
