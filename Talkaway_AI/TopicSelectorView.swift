//
//  TopicSelectorView.swift
//  Talkaway_AI
//
//  Created by 陳冠霖 on 2023/9/17.
//

import SwiftUI

struct Topic {
    let name: String
    let iconName: String
}


struct TopicSelectorView: View {
    @Binding var selectedTopicIndex: Int
    @Binding var isTopicSelectorPresented: Bool
    var topics: [Topic]

    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        GeometryReader { geometry in
            VStack{
                Spacer()
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<topics.count, id: \.self) { index in
                        Button(action: {
                            selectedTopicIndex = index
                            isTopicSelectorPresented = false
                        }) {
                            VStack {
                                Image(systemName: topics[index].iconName)
                                Text(topics[index].name)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}


struct TopicSelectorView_Previews: PreviewProvider {
    @State static var previewSelectedTopicIndex: Int = 0
    @State static var isTopicSelectorPresentedPreview: Bool = true

    static let previewTopics: [Topic] = [
        Topic(name: "旅遊", iconName: "airplane"),
        Topic(name: "運動", iconName: "figure.walk"),
        Topic(name: "學習", iconName: "a.book.closed.fill"),
        Topic(name: "娛樂", iconName: "gamecontroller"),
        Topic(name: "時事", iconName: "play.tv"),
    ]

    static var previews: some View {
        TopicSelectorView(
            selectedTopicIndex: $previewSelectedTopicIndex,
            isTopicSelectorPresented: $isTopicSelectorPresentedPreview,
            topics: previewTopics
        )
    }
}
