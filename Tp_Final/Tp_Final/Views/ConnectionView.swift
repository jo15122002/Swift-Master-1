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
                List(self.$model.periphList){ periph in
                    PeripheralView(model: periph)
                        .onTapGesture {
                            model.connectToPeripheral(periph: periph.wrappedValue)
                        }
                }
                
            }
            .padding()
            .sheet(isPresented: $model.isConnected, content: {
                SelectView()
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
