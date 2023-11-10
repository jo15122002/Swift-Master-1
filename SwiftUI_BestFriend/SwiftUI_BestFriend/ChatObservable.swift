//
//  ChatObservable.swift
//  SwiftUI_BestFriend
//
//  Created by digital on 10/11/2023.
//

import Foundation

class ChatObservable:ObservableObject{
    private var apiService = APIService()
    
    @Published var messageList = [Message]()
    
    func sendChat(message:String){
        self.addMessage(message: Message(message: message, username: "Jojo"))
        self.apiService.sendCompletionRequest(prompt: message) { content in
            self.addMessage(message: Message(message: content, username: "Mistral"))
        }
    }
    
    func addMessage(message:Message){
        DispatchQueue.main.async{
            self.messageList.append(message)
        }
    }
}
