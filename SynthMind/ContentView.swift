//
//  ContentView.swift
//  SynthMind
//
//  Created by Matthew Ogtong on 2/7/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var chatMessages: [ChatMessage] = []
    @State var messageText: String = ""
    @State var cancellables = Set<AnyCancellable>()
    
    let openAIService = OpenAIService()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(chatMessages, id: \.id) { message in
                        messageView(message: message)
                    }
                }
            }
            HStack {
                TextField("Enter a message", text: $messageText) {
                    
                }
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(12)
                Button {
                    sendMessage()
                } label: {
                    Text("Send")
                        .foregroundColor(.white)
                        .padding()
                        .background(.black)
                        .cornerRadius(12)
                }
                
            }
        }
        .padding()
    }
    
    func messageView(message: ChatMessage) -> some View {
        HStack {
            if message.sender == .me {
                Spacer()
            }
            Text(message.content)
                .foregroundColor(.white)
                .padding()
                .background(message.sender == .me ? .blue : .gray.opacity(0.1))
                .cornerRadius(12)
            if message.sender == .gpt {
                Spacer()
            }
        }
    }
    
    func sendMessage() {
        let myMessage = ChatMessage(id: UUID().uuidString, content: messageText, dateCreated: Date(), sender: .me)
        chatMessages.append(myMessage)
        openAIService.sendMessage(message: messageText).sink { completion in
            // handle error
        } receiveValue: { response in
            guard let textResponse = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else { return }
            let gptMessage = ChatMessage(id: response.id, content: textResponse, dateCreated: Date(), sender: .gpt)
            chatMessages.append(gptMessage)
        }
        .store(in: &cancellables)
        
        messageText = ""
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
