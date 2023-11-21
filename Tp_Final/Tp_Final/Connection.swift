//
//  Connection.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import Foundation
import UIKit
import CoreLocation

class Connection:ObservableObject{
    @Published var periphList = [Peripheral]()
    @Published var isScanning = false
    @Published var isConnected = false
    @Published var messagesReceived = [Message]()
    
    @Published var axisArray:[Axis] = [Axis]()
    @Published var citiesReceived:[City] = [City]()
    @Published var citiesPins:[MapAnnotationItem] = [MapAnnotationItem]()
    private var nbDataReceived = 0
    
    static var instance = Connection()
    
    var connectedPeriph:Peripheral?
    
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
    
    func connectToPeripheral(periph:Peripheral, callback:@escaping (()->())){
        if let cbperiph = periph.cbPeriph{
            BLEManager.instance.connectPeripheral(cbperiph) { connectedPeriph in
                self.stopScan()
                self.isConnected = true
                callback()
            }
        }
    }
    
    func disconnectFromPeripheral(){
        if let cbPeriph = connectedPeriph?.cbPeriph{
            BLEManager.instance.disconnectPeripheral(cbPeriph){_ in
                self.isConnected = false
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
    
    func switchCharacteristic(characteristic:String, callback: @escaping (()->())){
        self.disconnectFromPeripheral()
        BLEManager.instance.setCharacteristicUUID(uuid: characteristic)
        self.connectToPeripheral(periph: self.connectedPeriph!){
            print("callback switch")
            callback()
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
                        if(self.citiesReceived.count < 7){
                            let city = City(name: stringValue)
                            if(!self.citiesReceived.contains(city)){
                                self.citiesReceived.insert(City(name: stringValue), at: 0)
                                self.geocodeCityName(cityName: stringValue)
                            }
                            print("nouveau string")
                        }else{
                            self.sendData(message: "stopCities")
                        }
                    }
                }
            }
        }
    }
    
    func geocodeCityName(cityName: String) {
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(cityName) { (placemarks, error) in
                guard let location = placemarks?.first?.location else {
                    print("Erreur de géocodage: \(error?.localizedDescription ?? "Erreur inconnue")")
                    return
                }
                
                let annotation = MapAnnotationItem(coordinate: location.coordinate, title: cityName)
                self.citiesPins.insert(annotation, at: 0)
            }
        }
}
