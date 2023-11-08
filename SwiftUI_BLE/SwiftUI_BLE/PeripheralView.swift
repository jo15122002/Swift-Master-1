//
//  PeripheralView.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import SwiftUI

struct PeripheralView: View {
    
    @Binding var model:Peripheral
    
    var body: some View {
        VStack{
            Text(model.name)
            Text(model.cbPeriph?.identifier.uuidString ?? "unknown")
        }
    }
}

#Preview {
    @State var peripheral:Peripheral = Peripheral.defaultPeripheral()
    return PeripheralView(model: $peripheral)
}
