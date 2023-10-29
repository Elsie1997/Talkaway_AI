//
//  GoogleTTSManager.swift
//  Talkaway_AI
//
//  Created by 陳冠霖 on 2023/10/30.
//

import Foundation

class GoogleTTSManager {
    func fetchGoogleTTS(text: String, completion: @escaping (Data?) -> Void) {
        let apiKey = apiKey
        let apiUrl = "https://texttospeech.googleapis.com/v1/text:synthesize?key=\(apiKey)"
        let postBody = [
            "input": [
                "text": text
            ],
            "voice": [
                "languageCode": "en-US",
                "name": "en-US-Wavenet-C"
            ],
            "audioConfig": [
                "audioEncoding": "MP3"
            ]
        ]

        guard let url = URL(string: apiUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: postBody, options: .prettyPrinted)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let ttsResponse = try JSONDecoder().decode(GoogleTTSResponse.self, from: data)
                    let audioData = Data(base64Encoded: ttsResponse.audioContent)
                    completion(audioData)
                } catch {
                    print(error)
                    completion(nil)
                }
            } else {
                print(error ?? "Unknown error")
                completion(nil)
            }
        }.resume()
    }
}

struct GoogleTTSResponse: Decodable {
    let audioContent: String
}

