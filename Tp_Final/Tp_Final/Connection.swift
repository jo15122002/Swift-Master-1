//
//  Connection.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import Foundation
import UIKit

class Connection:ObservableObject{
    @Published var periphList = [Peripheral]()
    @Published var isScanning = false
    @Published var isConnected = false
    @Published var messagesReceived = [Message]()
    
    @Published var axisArray:[Axis] = [Axis]()
    @Published var stringReceived:[String] = [String]()
    private var nbDataReceived = 0
    
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
            BLEManager.instance.sendData(data: stringData)
        }
    }
    
    func sendData(image:UIImage){
        if let data = image.pngData(){
            BLEManager.instance.sendData(data: data)
        }
    }
    
    func listenForMessage(){
        BLEManager.instance.listenForMessages { data in
            print("message")
            if let d = data{
                print(d)
                if let convertedData = DataBytesManager.instance.convertData(data: d){
                    if let doubleValue = convertedData as? Double{ //alors ça vient de l'accelero
                        if(self.nbDataReceived < 30){
                            let axisNames = ["x", "y", "z"]
                            let axis = Axis(axis: axisNames[self.nbDataReceived%3], value: doubleValue, index: self.nbDataReceived/3)
                            self.axisArray.append(axis)
                            print("nouveau double")
                            self.nbDataReceived += 1
                        }else{
                            self.sendData(message: "stopAccelero")
                        }
                    }
                    
                    if let stringValue = convertedData as? String{
                        self.stringReceived.append(stringValue)
                        print("nouveau string")
                    }
                }
            }
        }
    }
}
