//
//  MessageView.swift
//  SwiftUI_BestFriend
//
//  Created by digital on 10/11/2023.
//

import SwiftUI

struct MessageView: View {
    var message:Message
    var body: some View {
        HStack{
            if message.username.elementsEqual("Jojo"){
                Spacer()
            }
            VStack{
                Text(message.username)
                Text(message.message)
            }
        }
    }
}

#Preview {
    let message = Message.defaultMessage()
    return MessageView(message: message)
}

