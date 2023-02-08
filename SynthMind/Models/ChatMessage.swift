//
//  ChatMessage.swift
//  SynthMind
//
//  Created by Matthew Ogtong on 2/7/23.
//

import Foundation
import SwiftUI

enum MessageSender {
    case me
    case gpt
}

struct ChatMessage {
    
    let id: String
    let content: String
    let dateCreated: Date
    let sender: MessageSender
    
}

extension ChatMessage {
    static let sampleMessages = [
        ChatMessage(id: UUID().uuidString, content: "Sample message from me", dateCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample message from gpt", dateCreated: Date(), sender: .gpt),
        ChatMessage(id: UUID().uuidString, content: "Sample message from me", dateCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample message from gpt", dateCreated: Date(), sender: .gpt)
    ]
}
