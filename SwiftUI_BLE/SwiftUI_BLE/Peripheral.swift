//
//  Peripheral.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import Foundation
import CoreBluetooth

struct Peripheral:Identifiable,Equatable{
    var id = UUID().uuidString
    var name:String
    var cbPeriph:CBPeripheral?
}

extension Peripheral{
    static func defaultPeripheral() -> Peripheral{
        return Peripheral(name: "Default")
    }
    
    static func == (lhs:Self, rhs:Self)->Bool{
        if let lperiph = lhs.cbPeriph,
           let rperiph = rhs.cbPeriph{
            return lperiph.identifier == rperiph.identifier
        }
        return false
    }
}
