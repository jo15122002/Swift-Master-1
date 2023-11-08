//
//  Connection.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import Foundation

struct Connection{
    var periphList = [Peripheral]()
    
    mutating func addPeripheral(periph:Peripheral){
        if(!periphList.contains(periph)){
            self.periphList.append(periph)
        }
    }
}
