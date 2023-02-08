//
//  OpenAIService.swift
//  SynthMind
//
//  Created by Matthew Ogtong on 2/8/23.
//

import Foundation
import Alamofire

class OpenAIService {
    let baseUrl = "https://api.openai.com/v1/"
    
    func sendMessage(message: String) {
        let body = OpenAICompletionsBody(model: "text-davinci-003", prompt: message, temperature: 0.7)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(String(describing: Constants.openAIAPIKey!))"
        ]
        AF.request(baseUrl + "completions", method: .post, parameters: body, encoder: .json, headers: headers).responseString { data in
            print(data.result)
        }
    }
}

struct OpenAICompletionsBody: Encodable {
    let model: String
    let prompt: String
    let temperature: Float?
}

