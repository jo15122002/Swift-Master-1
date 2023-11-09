//
//  ContentView.swift
//  SwiftUI_WS
//
//  Created by digital on 09/11/2023.
//

import SwiftUI

struct ConnectionView: View {
    @State var message:String = ""
    @ObservedObject var connection = Connection()
    
    var body: some View {
        VStack {
            VStack{
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text(connection.isConnected ? "Connected" : "Disconnected")
            }.onTapGesture {
                if(!connection.isConnected){
                    connection.connectToUrl(url: "ws://172.28.55.240:8080/dmii")
                }else{
                    connection.disconnect()
                }
            }
            List(self.$connection.messageList){message in
                MessageView(message: message.wrappedValue)
            }
            TextField("Message to send", text: $message)
                .disabled(!connection.isConnected)
                .onSubmit {
                    self.connection.sendMessage(message: message)
                }
        }
        .padding()
    }
}

#Preview {
    ConnectionView()
}
