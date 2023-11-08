//
//  BLEConnectionViewModel.swift
//  SwiftUI_BLE
//
//  Created by Al on 03/11/2023.
//

import Foundation
import CoreBluetooth

class BLEConnectionViewModel:ObservableObject {
    
    @Published var bleObjects:[BLEObjectViewModel] = []
    @Published var connectedBLEObject:BLEObjectViewModel?
    @Published var isScaning = false
    
    func addNewBLEObject(bleObject:BLEObjectViewModel) {
        if !bleObjects.contains(bleObject){
            bleObjects.append(bleObject)
        }
    }
    
    func startScan(){
        isScaning = true
        BLEManager.instance.scan { periph, name in
            self.addNewBLEObject(bleObject: BLEObjectViewModel(name: name,periph: periph))
        }
    }
    
    func stopScan(){
        BLEManager.instance.stopScan()
        isScaning = false
    }
    
    func disconnect(bleObject:BLEObjectViewModel){
        if let periph = bleObject.periph{
            BLEManager.instance.disconnectPeripheral(periph) { periph in
                self.connectedBLEObject = nil
            }
        }
    }
    
    func connect(bleObject:BLEObjectViewModel) {
        
        if let periph = bleObject.periph{
            BLEManager.instance.connectPeripheral(periph) { connectedPeriph in
                self.connectedBLEObject = bleObject
            }
        }
        
    }
    
    func sendMessage(str:String) {
        BLEManager.instance.sendData(data: str.data(using: .utf8)!)
    }
    
    func listenForMessage(_ callback:@escaping (Data?)->()){
        BLEManager.instance.listenForMessages(callback: callback)
    }
    
}

extension BLEConnectionViewModel {
    
    static func defaultBLEConnectionViewModel() -> BLEConnectionViewModel {
        
        var objectList = (0..<10).map{ BLEObjectViewModel(name: "MonObjet \($0)") }
        
        let instance = BLEConnectionViewModel()
        instance.bleObjects = objectList
        
        return instance
    }
    
    static func defaultEmptyBLEConnectionViewModel() -> BLEConnectionViewModel {
        
        var objectList = (0..<0).map{ BLEObjectViewModel(name: "MonObjet \($0)") }
        
        let instance = BLEConnectionViewModel()
        instance.bleObjects = objectList
        
        return instance
    }
    
    static func defaultBigBLEConnectionViewModel() -> BLEConnectionViewModel {
        
        var objectList = (0..<100).map{ BLEObjectViewModel(name: "MonObjet \($0)") }
        
        let instance = BLEConnectionViewModel()
        instance.bleObjects = objectList
        
        return instance
    }
    
}
