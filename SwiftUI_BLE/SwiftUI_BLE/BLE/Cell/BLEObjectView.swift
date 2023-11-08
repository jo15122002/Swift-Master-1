//
//  BLEObjectView.swift
//  SwiftUI_BLE
//
//  Created by Al on 03/11/2023.
//

import SwiftUI

struct BLEObjectView: View {
    
    var model:BLEObjectViewModel
    
    var body: some View {
        HStack{
            Text(model.name)
            Image(uiImage: .checkmark)
        }
    }
}

#Preview {
    BLEObjectView(model: BLEObjectViewModel.defaultBLEObjectViewModel())
}
