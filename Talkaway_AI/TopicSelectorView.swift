//
//  TopicSelectorView.swift
//  Talkaway_AI
//
//  Created by 陳冠霖 on 2023/9/17.
//

import SwiftUI

struct TopicCell: View {
    let scenario: ChatScenario

    var body: some View {
        VStack {
            Image(systemName: scenario.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding()
            Text(scenario.topic)
        }
    }
}

struct TopicSelectorView: View {
    @Binding var currentScenario: ChatScenario?
    @Binding var isTopicSelectorPresented: Bool
    
    var scenarios: [ChatScenario]
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(scenarios, id: \.topic) { scenario in
                        Button(action: {
                            currentScenario = scenario
                            isTopicSelectorPresented.toggle()
                        }) {
                            TopicCell(scenario: scenario)
                        }
                        .padding(.all, 5)
                    }
                }
            }
        }
    }
}
