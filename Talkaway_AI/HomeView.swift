//
//  HomeView.swift
//  Talkaway_AI
//
//  Created by kuanlin on 2023/9/17.
//
import SwiftUI

struct HomeView: View {
    @State private var showingImagePicker = false
    @State private var userImage: UIImage?
    @State private var topicIndex = 0
    var topics = [
        "旅遊", "運動", "學習",
        "娛樂", "時事", "購物",
        "事業", "社交", "美食"
    ]
    
    var body: some View {
        // 支援導向其他view(能被導向的view元素都應該放在這裡面)
        NavigationView {
            VStack {
                // Avatae
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
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.black, lineWidth: 2)
                        )
                        .padding(.bottom, 20)
                        .offset(y:  -50)
                        .onTapGesture {
                            showingImagePicker = true

                        }
                }
                
                // 把Text 和 旁邊的按鈕放在一行上
                HStack {
                    Text("今天來聊聊\(topics[topicIndex])")
                    
                    Button(action: {
                        topicIndex = (topicIndex + 1) % topics.count
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
                    Text("開始談話")
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
            .background(Color(hex:0xCA5CDD))
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $userImage)
            }
        }
    }
    
    func loadImage() {
        // 可加入你想要的處理圖片後的動作。
    }
}



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



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
