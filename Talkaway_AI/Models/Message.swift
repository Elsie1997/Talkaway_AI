//
//  Message.swift
//  Talkaway_AI
//
//  Created by 陳冠霖 on 2023/10/10.
//

import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
    let audioURL: URL?
    let hasAudio: Bool
}
