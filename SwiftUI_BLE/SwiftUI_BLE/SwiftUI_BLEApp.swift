//
//  SwiftUI_BLEApp.swift
//  SwiftUI_BLE
//
//  Created by digital on 08/11/2023.
//

import SwiftUI

@main
struct SwiftUI_BLEApp: App {
    
    var ble = BLEManager.instance
    
    var body: some Scene {
        WindowGroup {
            ConnectionView()
        }
    }
}
