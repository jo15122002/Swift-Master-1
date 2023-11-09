//
//  ContentView.swift
//  SwiftUI_WS
//
//  Created by digital on 09/11/2023.
//

import SwiftUI

struct ConnectionView: View {
    @State var message:String = ""
    @State var image = UIImage()
    @ObservedObject var connection = Connection()
    @State var showSheet = false
    
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
            HStack{
                TextField("Message to send", text: $message)
                    .disabled(!connection.isConnected)
                    .onSubmit {
                        self.connection.sendMessage(message: message)
                    }
                Text("Select photo")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(16)
                        .foregroundColor(.white)
                        .onTapGesture {
                            showSheet = true
                        }
            }
        }
        .padding()
        .sheet(isPresented: $showSheet, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        })
        .onChange(of: image, perform: { value in
            print("send image")
            connection.sendMessage(data: image.pngData()!)
        })
    }
}

#Preview {
    ConnectionView()
}
