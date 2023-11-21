//
//  MapView.swift
//  Tp_Final
//
//  Created by digital on 21/11/2023.
//

import SwiftUI

struct CitiesView: View {
    @ObservedObject var connection:Connection = Connection()
    var body: some View {
        VStack{
            Text("Map")
            Spacer()
            MapView(annotations: connection.citiesPins)
            ScrollView(.horizontal){
                HStack{
                    ForEach(connection.citiesReceived){city in
                        Text(city.name)
                    }
                }
            }
            Text("Start").onTapGesture {
                connection.listenForMessage()
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
