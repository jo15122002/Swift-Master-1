//
//  ContentView.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import SwiftUI

struct ConnectionView: View {
    
    @State var periphList = [Peripheral]()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Scan")
                .onTapGesture(perform: {
                    BLEManager.instance.scan { periph, nom in
                        periphList.append(Peripheral(name: nom, cbPeriph: periph))
                    }
                })
            List($periphList){ periph in
                PeripheralView(model: periph)
            }
        }
        .padding()
    }
}

#Preview {
    ConnectionView()
}
