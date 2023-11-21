//
//  DatBytesManager.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import Foundation

class DataBytesManager{
    let names:[UInt8:String] = [
        0x01:"Jean Kenny",
        0x02:"Roxanne",
        0x03:"Lucie",
        0x04:"Anaïs",
        0x05:"Max",
        0x06:"Joyce",
        0x07:"Lucas",
        0x08:"Romain",
        0x09:"Yohan"
    ]
    
    static let instance = DataBytesManager()
    
    func appendPrefix(userId:UInt8, dataType:UInt8, to data:Data) -> Data{
        var bytes = [UInt8](data)
        bytes.insert(dataType, at: 0)
        bytes.insert(userId, at: 0)
        return Data(bytes: bytes)
    }
    
    func convertToData(data:Data)->(username:String, dataType:DataType, data:Data)?{
        var bytes = [UInt8](data)
        if let userIdBytes = bytes.first{
            bytes = Array(bytes.dropFirst())
            if let name = names[userIdBytes]{
                if let dataTypeByte = bytes.first{
                    bytes = Array(bytes.dropFirst())
                    if let type = DataType(rawValue: dataTypeByte){
                        return (name, type, Data(bytes))
                    }
                }
            }
        }
        return nil
    }
}
