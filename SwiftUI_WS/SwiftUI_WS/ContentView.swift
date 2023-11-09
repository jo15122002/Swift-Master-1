//
//  ContentView.swift
//  SwiftUI_WS
//
//  Created by digital on 09/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State var message:String = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            TextField("Message to send", text: $message)
                .onSubmit {
                    WebSocketManager.instance.connectToUrl(url: "ws://172.28.55.240:8080/dmii"){
                        print(message)
                        WebSocketManager.instance.sendMessage(message: message){
                            WebSocketManager.instance.disconnect()
                        }
                    }
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
