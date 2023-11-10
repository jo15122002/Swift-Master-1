//
//  ContentView.swift
//  SwiftUI_BestFriend
//
//  Created by digital on 10/11/2023.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject private var chatObservable = ChatObservable()
    @State var message = ""
    var body: some View {
        List(self.$chatObservable.messageList){message in
            MessageView(message: message.wrappedValue)
        }.padding()
        
        TextField("Message to send…", text: $message)
            .onSubmit {
                self.chatObservable.sendChat(message: message)
                self.message = ""
            }.padding()
    }
}

#Preview {
    ChatView()
}
