//
//  MessageView.swift
//  SwiftUI_WS
//
//  Created by digital on 09/11/2023.
//

import SwiftUI

struct MessageView: View {
    var message:Message
    var body: some View {
        HStack{
            if message.userName.elementsEqual("Jojo"){
                Spacer()
            }
            VStack{
                Text(message.userName)
                Text(message.getText()!)
            }
        }
    }
}

#Preview {
    let message = Message.defaultMessage()
    return MessageView(message: message)
}
