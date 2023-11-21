//
//  DatBytesManager.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import Foundation

class DataBytesManager{
    
    static let instance = DataBytesManager()
    
    func convertData(data:Data) -> Any?{
        if let doubleValue = Double(String(data: data, encoding: .utf8) ?? "") {
            return doubleValue
        }
        
        if let stringValue = String(data: data, encoding: .utf8) {
                return stringValue
            }

        // Si les deux conversions échouent, renvoyez nil ou gérez l'erreur
        return nil
    }
}
