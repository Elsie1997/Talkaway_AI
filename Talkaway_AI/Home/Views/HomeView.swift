//
//  HomeView.swift
//  Talkaway_AI
//
//  Created by kuanlin on 2023/9/17.
//
import SwiftUI


struct HomeView: View {
    @ObservedObject var chatScenarioViewModel = ChatScenarioViewModel()
    
    @State private var isTopicSelectorPresented: Bool = false
    
    var body: some View {
        // 支援導向其他view(能被導向的view元素都應該放在這裡面)
        NavigationView {
            ZStack{
                // 這是一個佔滿畫面的透明按鈕，當點擊時，它會關閉懸浮九宮格
                Button(action: {
                    isTopicSelectorPresented = false
                }) {
                    Color.clear
                        .edgesIgnoringSafeArea(.all)
                }
                
                Text("歡迎回來！")
                    .bold(true)
                    .font(.system(size: 25))
                    .padding([.top, .leading], -150)
                    .padding(.top, -180)
                
                VStack {
                    // 把Text 和 旁邊的按鈕放在一行上
                    HStack {
                        Text("今天來聊聊")
                        
                        Button(action: {
                            isTopicSelectorPresented.toggle()
                        }) {
                            Text(chatScenarioViewModel.currentScenario?.topic ?? "選擇主題")
                                .font(.system(size: 20))
                                
                        }
                        
                        Button(action: {
                            chatScenarioViewModel.randomScenario()
                        }) {
                            Image(systemName: "arrow.2.circlepath")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.bottom, 50)
                    
                    // 首頁導向按鈕
                    NavigationLink(destination:  ChooseChatView(selectedChatScenario: chatScenarioViewModel.currentScenario!)) {
                        Text("前往談話")
                            .font(.headline)
                            .frame(width: 200, height: 14)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .padding(.bottom, 8)
                    
                    NavigationLink(destination: AdvicePage()) {
                        Text("改善建議")
                            .font(.headline)
                            .frame(width: 200, height: 15)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .disabled(true)
                        
                    
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .blur(radius: isTopicSelectorPresented ? 10: 0)
                .padding(.bottom, -150)
                .offset(y: -50)
                
                
                
                // 懸浮九宮格視窗
                if isTopicSelectorPresented {
                    TopicSelectorView(
                        currentScenario: $chatScenarioViewModel.currentScenario,
                        isTopicSelectorPresented: $isTopicSelectorPresented,
                        scenarios: chatScenarioViewModel.scenarios
                    )
                    .frame(width: 280, height: 350)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                }
            }
            .background(Color(hex:0xE4C8DE))
            .navigationViewStyle(.stack)
        }
    }
}

struct AdvicePage: View {
    var body: some View {
        VStack {
            Text("改善建議功能")
        }
    }
}

// 預覽
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
