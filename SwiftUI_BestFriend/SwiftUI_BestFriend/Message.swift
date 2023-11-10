//
//  Message.swift
//  SwiftUI_BestFriend
//
//  Created by digital on 10/11/2023.
//

import Foundation

struct Message:ModelProtocol{
    var id = UUID().uuidString
    var message:String
    var username:String
}

extension Message {
    static func defaultMessage()->Message{
        return Message(message: "Aye Caramba", username: "Jojo")
    }
}
