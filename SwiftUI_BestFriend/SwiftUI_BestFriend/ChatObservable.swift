//
//  ChatObservable.swift
//  SwiftUI_BestFriend
//
//  Created by digital on 10/11/2023.
//

import Foundation
import UIKit

class ChatObservable:ObservableObject{
    private var apiService = APIService()
    private var apiImageService = APIServiceImage()
    
    @Published var messageList = [Message]()
    
    private var id = 0;
    
    func sendChat(message:String, image:UIImage){
        if(image.size.width > 0){
            self.id += 1
            print("send image")
            self.addMessage(message: Message(userName: Settings.instance.username, text: message, image:image))
            let imageBase64 = image.pngData()?.base64EncodedString()
            self.apiImageService.sendCompletionRequest(prompt: self.buildMessage(newMessage: message, hasImage: true), imageData: [["data" : imageBase64, "id":self.id]]) { content in
                let formattedContent = content.replacingOccurrences(of: "\(Settings.instance.botname):", with: "")
                self.addMessage(message: Message(userName: Settings.instance.botname, text: formattedContent))
            }
        }else{
            self.addMessage(message: Message(userName: Settings.instance.username, text: message))
            self.apiService.sendCompletionRequest(prompt: self.buildMessage(newMessage: message)) { content in
                let formattedContent = content.replacingOccurrences(of: "\(Settings.instance.botname):", with: "")
                self.addMessage(message: Message(userName: Settings.instance.botname, text: formattedContent))
            }
        }
        
    }
    
    func addMessage(message:Message){
        DispatchQueue.main.async{
            self.messageList.append(message)
        }
    }
    
    func buildMessage(newMessage:String, hasImage:Bool = false)->String{
        var formattedPrompt = ""
        if(!hasImage){
            formattedPrompt = "\(Settings.instance.getFormattedContextPrompt())\n"
            
            messageList.forEach{message in
                formattedPrompt += "\(message.userName): \(message.text)\n"
            }
        }
        print(self.id)
        formattedPrompt += "\(Settings.instance.username): \(hasImage ? "[img-\(self.id)] " : "") \(newMessage) \n ASSISTANT: "
        
        return formattedPrompt
    }
}
