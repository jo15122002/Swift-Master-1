//
//  ContentView.swift
//  test
//
//  Created by Al on 07/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var monText = "Tata"
    @State var sliderValue = 0.0
    
    @ObservedObject var example = ExampleObservable()
    
    var body: some View {
        HStack{
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .onTapGesture {
                        example.doAfter()
                    }
                Text("TOTO")
                    .foregroundStyle(.blue)
                    .onTapGesture {
                        // Code a executer
                        print("Salut")
                        // label.text = monText NON!
                        monText = "TYTY"
                    }
                Text("\(example.maProp)")
            }
            Slider(value: $sliderValue)
            VStack{
                Text(monText)
                Text(" \(sliderValue) ")
            }
        }
        .padding()
        .onChange(of: monText, perform: { value in
            print(value)
            // Execution de code métier
            
        }).onChange(of: sliderValue, perform: { value in
            print(value)
        }).onChange(of: example.maProp, perform: { value in
            print(value)
        })
    }
}

#Preview {
    ContentView()
}
