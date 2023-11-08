//
//  ContentView.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import SwiftUI

struct ConnectionView: View {
    
    @ObservedObject var model:Connection = Connection()
    
    @State var message:String = "";
    @State private var image = UIImage()
    @State private var showSheet = false
    
    var body: some View {
        
            VStack {
                HStack{
                    Text(model.isConnected ? "Connected" : "Not connected")
                    
                    VStack{
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Scan")
                            .onTapGesture(perform: {
                                model.isScanning ? model.stopScan() : model.startScan()
                            })
                    }.padding()
                    
                    Text(model.isScanning ? "Scanning" : "Stopped")
                }
                
                if(model.isConnected){
                    TextField("Message to send", text: $message)
                        .onSubmit {
                            model.sendData(message: message)
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
                    Image(uiImage: image)
                    
                }else{
                    List(self.$model.periphList){ periph in
                        PeripheralView(model: periph)
                            .onTapGesture {
                                model.connectToPeripheral(periph: periph.wrappedValue)
                            }
                    }
                }
                
            }
            .padding()
            .sheet(isPresented: $showSheet, content: {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
            })
            .onChange(of: image, perform: { value in
                print("send image")
                model.sendData(image: image)
            })
    }
}

#Preview {
    ConnectionView()
}
