//
//  Utility.swift
//  Talkaway_AI
//
//  Created by 陳冠霖 on 2023/10/30.
//

import Foundation

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
