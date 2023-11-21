//
//  MapView.swift
//  Tp_Final
//
//  Created by digital on 21/11/2023.
//

import SwiftUI

struct CitiesView: View {
    @ObservedObject var connection:Connection = Connection.instance
    var body: some View {
        VStack{
            Text("Map")
            MapView(annotations: connection.citiesPins)
            ScrollView(.horizontal){
                HStack{
                    ForEach(connection.citiesReceived){city in
                        Text(city.name)
                            .onTapGesture {
                                print("tap on city")
                                self.connection.askMistral(city: city.name)
                            }
                            .padding()
                            .background(.gray)
                    }
                }
            }
            Text(self.connection.mistralresponse)
            Text("Start").onTapGesture {
                connection.switchCharacteristic(characteristic: "558759EE-0F86-49E7-A38A-DBE48CF8B237"){
                    connection.listenForMessage()
                }
            }
        }
    }
}

#Preview {
    CitiesView()
}

struct City:Identifiable, Equatable{
    var id:String = UUID().uuidString
    var name:String
    
    static func == (lhs:Self, rhs:Self)->Bool{
        return lhs.name == rhs.name
    }
}
