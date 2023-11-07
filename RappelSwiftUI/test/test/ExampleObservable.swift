//
//  ExampleObservable.swift
//  test
//
//  Created by Al on 07/11/2023.
//

import Foundation

class ExampleObservable : ObservableObject {
    
    @Published var maProp:Int = 0
    
    func doAfter() {
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            self.maProp = 3
        }
        
    }
    
}
