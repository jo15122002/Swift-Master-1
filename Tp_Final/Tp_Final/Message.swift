//
//  Message.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import Foundation
import UIKit

struct Message:ModelProtocol{
    var id = UUID().uuidString
    
    var data:Data?
    var date:Date = Date.now
    var dataType:DataType
    var userName:String
}

extension Message {
    func getText() -> String?{
        if let d = data{
            if(dataType == .Text){
                return String(data: d, encoding: .utf8)
            }
        }
        return nil
    }
    
    func getImage() -> UIImage?{
        if let d = data{
            if(dataType == .Image){
                return UIImage(data: d)
            }
        }
        return nil
    }
    
    static func defaultMessage()->Message{
        return Message(data: "Un message super cool".data(using: .utf8), dataType: DataType.Text, userName: "Jojo")
    }
}


enum DataType:UInt8{
    case Text=0x01
    case Image=0x02
}
