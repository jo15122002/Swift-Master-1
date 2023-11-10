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
        print(Settings.instance.username)
        print(Settings.instance.botname)
        self.addMessage(message: Message(message: message, username: Settings.instance.username))
        self.apiService.sendCompletionRequest(prompt: self.buildMessage(newMessage: message)) { content in
            let formattedContent = content.replacingOccurrences(of: "\(Settings.instance.botname):", with: "")
            self.addMessage(message: Message(message: formattedContent, username: Settings.instance.botname))
        }
    }
    
    func addMessage(message:Message){
        DispatchQueue.main.async{
            self.messageList.append(message)
        }
    }
    
    func buildMessage(newMessage:String)->String{
        var formattedPrompt = "\(Settings.instance.getFormattedContextPrompt())\n"
        
        messageList.forEach{message in
            formattedPrompt += "\(message.username): \(message.message)\n"
        }
        
        formattedPrompt += "\(Settings.instance.username): \(newMessage)"
        
        return formattedPrompt
    }
}
