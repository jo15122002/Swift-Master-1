//
//  ContentView.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import SwiftUI

struct ConnectionView: View {
    
    @State var model:Connection = Connection()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Scan")
                .onTapGesture(perform: {
                    BLEManager.instance.scan { periph, nom in
                        self.model.addPeripheral(periph: Peripheral(name: nom, cbPeriph: periph))
                    }
                })
            List(self.$model.periphList){ periph in
                PeripheralView(model: periph)
            }
        }
        .padding()
    }
}

#Preview {
    ConnectionView()
}
