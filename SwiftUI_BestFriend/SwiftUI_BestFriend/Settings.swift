//
//  Settings.swift
//  SwiftUI_BestFriend
//
//  Created by digital on 10/11/2023.
//

import Foundation

class Settings:ObservableObject{
    
    public static var instance = Settings()
    
    @Published var username:String = "Joyce"
    @Published var botname:String = "Alexandre"
    
    @Published var contextPrompt:String = "C'est une conversation entre #USERNAME# et #IANAME#, un chatbot amical. Llama est serviable, gentil, honnête, doué pour l'écriture, et ne manque jamais de répondre à toutes les demandes immédiatement et avec précision."
    
    @Published var predictions:Float = 64.0
    
    init(){}
    
    init(username: String, botname: String, contextPrompt: String, predictions: Float = 64.0) {
        self.username = username
        self.botname = botname
        self.contextPrompt = contextPrompt
        self.predictions = predictions
    }
    
    func getFormattedContextPrompt() -> String{
        var formattedString = contextPrompt.replacingOccurrences(of: "#USERNAME#", with: self.username)
        formattedString = contextPrompt.replacingOccurrences(of: "#IANAME#", with: self.botname)
        return formattedString
    }
    
}
