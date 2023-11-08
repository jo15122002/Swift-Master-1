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
            Text(model.name).bold()
            Text(model.cbPeriph?.identifier.uuidString ?? "unknown").fontWidth(.compressed)
        }
    }
}

#Preview {
    @State var peripheral:Peripheral = Peripheral.defaultPeripheral()
    return PeripheralView(model: $peripheral)
}
