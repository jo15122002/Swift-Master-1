//
//  MessageView.swift
//  SwiftUI_WS
//
//  Created by digital on 09/11/2023.
//

import SwiftUI
import UIKit

struct MessageView: View {
    var message:Message
    var body: some View {
        HStack{
            if message.userName.elementsEqual("Jojo"){
                Spacer()
            }
            VStack{
                Text(message.userName)
                if(message.dataType == .Text){
                    Text(message.getText()!)
                }else{
                    Image(uiImage: message.getImage()!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: .infinity)
                        .clipped()
                }
            }
        }
    }
}

#Preview {
    let message = Message.defaultMessage()
    return MessageView(message: message)
}
