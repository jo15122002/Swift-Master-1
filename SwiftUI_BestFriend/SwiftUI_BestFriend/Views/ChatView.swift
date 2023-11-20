//
//  ContentView.swift
//  SwiftUI_BestFriend
//
//  Created by digital on 10/11/2023.
//

import SwiftUI
import UIKit

struct ChatView: View {
    @ObservedObject private var chatObservable = ChatObservable()
    @State var message = ""
    @State var showSettings = false
    @State var showImagePicker = false
    @State var image:UIImage = UIImage()
    
    var body: some View {
        VStack{
            List(self.$chatObservable.messageList){message in
                MessageView(message: message.wrappedValue)
            }.padding()
            
            HStack{
                Image("image")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 40, height: 10)
                    .padding()
                    .onTapGesture {
                        self.showImagePicker = true
                    }
                TextField("Message to send…", text: $message)
                    .onSubmit {
                        self.chatObservable.sendChat(message: message, image: image)
                        self.message = ""
                        self.image = UIImage()
                    }
                    .padding()
                
                Image("gear")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 30, height: 10)
                    .padding()
                    .onTapGesture {
                        self.showSettings = true
                    }
            }
        }.sheet(isPresented: $showSettings, content: {
            SettingsView()
        })
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(selectedImage: $image)
        })
    }
}

#Preview {
    ChatView()
}
