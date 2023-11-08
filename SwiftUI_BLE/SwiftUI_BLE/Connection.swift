//
//  Connection.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import Foundation

class Connection:ObservableObject{
    @Published var periphList = [Peripheral]()
    @Published var isScanning = false
    @Published var isConnected = false
    @Published var messagesReceived = [Message]()
    
    func addPeripheral(periph:Peripheral){
        if(!periphList.contains(periph)){
            self.periphList.append(periph)
        }
    }
    
    func startScan(){
        self.isScanning = true
        BLEManager.instance.scan { periph, nom in
            self.addPeripheral(periph: Peripheral(name: nom, cbPeriph: periph))
        }
    }
    
    func stopScan(){
        BLEManager.instance.stopScan()
        self.isScanning = false
    }
    
    func connectToPeripheral(periph:Peripheral){
        if let cbperiph = periph.cbPeriph{
            BLEManager.instance.connectPeripheral(cbperiph) { connectedPeriph in
                
                self.stopScan()
                self.isConnected = true
            }
        }
    }
    
    func sendData(message:String){
        if let stringData = message.data(using: .utf8){
            var data = DataBytesManager.instance.appendPrefix(userId: 0x06, dataType: DataType.Text.rawValue, to: stringData)
            BLEManager.instance.sendData(data: data)
        }
    }
    
    func listenForMessage(){
        BLEManager.instance.listenForMessages { data in
            if let d = data{
                if let infos = DataBytesManager.instance.convertToData(data: d){
                    let message = Message(data: infos.data, dataType: infos.dataType, userName: infos.username)
                    self.messagesReceived.append(message)
                }
            }
        }
    }
}
