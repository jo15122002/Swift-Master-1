//
//  GraphView.swift
//  Tp_Final
//
//  Created by digital on 21/11/2023.
//

import SwiftUI
import Charts

struct GraphView: View {
    var bleManager = BLEManager.instance
    @ObservedObject var connection:Connection = Connection.instance
    var body: some View {
        VStack{
            Chart(connection.axisArray){axis in
                LineMark(
                    x: .value("Index", axis.index),
                    y: .value("Value", axis.value)
                ).foregroundStyle(by: .value("Axis", axis.axis))
            }
            Text("Start")
                .onTapGesture {
                    print("tap")
                    connection.switchCharacteristic(characteristic: "6E400002-B5A3-F393-E0A9-E50E24DCCA9E")
                    connection.listenForMessage()
                }
        }
    }
}

#Preview {
    GraphView()
}

struct Axis:Identifiable{
    var id=UUID().uuidString
    
    var axis:String
    var value:Double
    var index:Int
    
    init(axis:String, value:Double, index:Int){
        self.axis = axis
        self.value = value
        self.index = index
    }
}
