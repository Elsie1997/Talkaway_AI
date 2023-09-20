//
//  HomeView.swift
//  Talkaway_AI
//
//  Created by kuanlin on 2023/9/17.
//
import SwiftUI


struct HomeView: View {
    var topics: [Topic] = [
        Topic(name: "旅遊", iconName: "airplane"),
        Topic(name: "運動", iconName: "figure.walk"),
        Topic(name: "學習", iconName: "a.book.closed.fill"),
        Topic(name: "娛樂", iconName: "gamecontroller"),
        Topic(name: "時事", iconName: "play.tv"),
        Topic(name: "購物", iconName: "smiley"),
        Topic(name: "事業", iconName: "suitcase"),
        Topic(name: "社交", iconName: "person.and.person.fill"),
        Topic(name: "美食", iconName: "fork.knife"),
    ]
    
    @State private var showingImagePicker = false
    @State private var userImage: UIImage?
    @State private var selectedTopicIndex: Int = 0
    @State private var isTopicSelectorPresented: Bool = false
    
    var body: some View {
        // 支援導向其他view(能被導向的view元素都應該放在這裡面)
        NavigationView {
            ZStack{
                VStack {
                    // Avatar
                    if let img = userImage{
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 250)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.black, lineWidth: 2)
                            )
                            .onTapGesture {
                                showingImagePicker = true
                            }
                    } else {
                        Image("logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 250)
                            .background(Circle().fill(Color(hex: 0xD8BFD8)))
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.black, lineWidth: 2)
                            )
                            .padding(.bottom, 20)
                            .offset(y: -50)
                            .onTapGesture {
                                showingImagePicker = true
                                
                            }
                    }
                    
                    // 把Text 和 旁邊的按鈕放在一行上
                    HStack {
                        Text("今天來聊聊")
                        
                        Button(action: {
                            isTopicSelectorPresented.toggle()
                        }) {
                            Text(topics[selectedTopicIndex].name)
                                .font(.headline)
                                .background(Color(hex: 0xD8BFD8))
                        }
                        
                        Button(action: {
                            selectedTopicIndex = (selectedTopicIndex + 1) % topics.count
                        }) {
                            Image(systemName: "arrow.2.circlepath")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.bottom, 10)
                    
                    // 首頁導向按鈕
                    NavigationLink(destination: FeaturePage()) {
                        Text("前往談話")
                            .font(.headline)
                            .frame(width: 200, height: 25)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    
                    NavigationLink(destination: AdvicePage()) {
                        Text("改善建議")
                            .font(.headline)
                            .frame(width: 200, height: 25)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }.disabled(true)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(selectedImage: $userImage)
                }
                .blur(radius: isTopicSelectorPresented ? 10: 0)
                
                // 懸浮九宮格視窗
                if isTopicSelectorPresented {
                    TopicSelectorView(
                        selectedTopicIndex: $selectedTopicIndex,
                        isTopicSelectorPresented: $isTopicSelectorPresented,
                        topics: topics
                    )
                    .frame(width: 280, height: 300)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                }
            }
        }
    } 
    
    func loadImage() {
        // 可加入你想要的處理圖片後的動作。
    }
}


// TODO
struct FeaturePage: View {
    var body: some View {
        VStack {
            Text("開始談話功能")
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
