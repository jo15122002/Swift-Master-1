//
//  ContentView.swift
//  SwiftUI_BLE
//
//  Created by Al on 03/11/2023.
//

import SwiftUI

struct BLEConnectionView: View {
    
    @StateObject var model = BLEConnectionViewModel.defaultEmptyBLEConnectionViewModel()
        
    @State var isConnected = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text(model.isScaning ? "Stop" : "Scan").onTapGesture {
                    model.isScaning ? model.stopScan() : model.startScan()
                }
                List(model.bleObjects) { bleObj in
                    NavigationLink(isActive: $isConnected, 
                                   destination: {
                        ChatView().environmentObject(model)
                    }, label: {
                        BLEObjectView(model: bleObj).onTapGesture {
                            model.connect(bleObject: bleObj)
                        }
                    })
                    
                }.onChange(of: model.connectedBLEObject, perform: { value in
                    if value == nil {
                        isConnected = false
                    }else{
                        isConnected = true
                        model.stopScan()
                    }
                })
            }.navigationTitle("BLE Connection")
            .padding()
            
        }.onAppear(perform: {
            _ = BLEManager.instance
        })
    }
}

#Preview {
    BLEConnectionView()
}
