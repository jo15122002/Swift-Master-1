//
//  MessageModel.swift
//  SwiftUI_WS
//
//  Created by digital on 09/11/2023.
//

import Foundation

class Connection:ObservableObject{
    @Published var messageList = [Message]()
    @Published var isConnected = false
    
    private let url:String = "ws://172.28.55.240:8080/dmii"
    
    var webSocketManager = WebSocketManager()
    
    func connectToUrl(url:String, callback:@escaping (()->()) = {}){
        self.webSocketManager.connectToUrl(url: url){
            self.isConnected = true
            self.listenForMessages()
            self.listenForImages()
            callback()
        }
    }
    
    func disconnect(){
        self.webSocketManager.disconnect(){
            self.isConnected = false
            self.stopListenForImages()
            self.stopListenForMessages()
        }
    }
    
    func sendMessage(message:String){
        if(self.isConnected){
            self.webSocketManager.sendMessage(message: message){
                self.addMessage(message: Message(data: message.data(using: .utf8), dataType: DataType.Text, userName: "Jojo"))
            }
        }
    }
    
    func sendMessage(data:Data){
        if(self.isConnected){
            self.webSocketManager.sendData(data: data){
                print("image sent")
                self.addMessage(message: Message(data: data, dataType: .Image, userName: "Jojo"))
            }
        }
    }
    
    func addMessage(message:Message){
        self.messageList.append(message)
    }
    
    func listenForMessages(){
        self.webSocketManager.setMessageReceivedCallback(callback: {message in
            self.addMessage(message: Message(data: message.data(using: .utf8), dataType: DataType.Text, userName: "Uknown"))
        })
    }
    
    func stopListenForMessages(){
        self.webSocketManager.setMessageReceivedCallback { message in
            
        }
    }
    
    func listenForImages(){
        self.webSocketManager.setImageReceivedCallback(callback: {image in
            self.addMessage(message: Message(data: image.pngData(), dataType: DataType.Image, userName: "Uknown"))
        })
    }
    
    func stopListenForImages(){
        self.webSocketManager.setImageReceivedCallback { image in
            
        }
    }
}
