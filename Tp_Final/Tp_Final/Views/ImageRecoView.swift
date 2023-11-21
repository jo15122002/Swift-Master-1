//
//  ImageRecoView.swift
//  Tp_Final
//
//  Created by digital on 21/11/2023.
//

import SwiftUI
import UIKit

struct ImageRecoView: View {
    @State var showImagePicker = false
    @State var selectedImage = UIImage()
    @ObservedObject var connection = Connection.instance
    @ObservedObject var imageReco = ImageRecognition()
    var body: some View {
        VStack{
            if(self.selectedImage.size.width > 0){
                Image(uiImage: self.selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
            }
        Text(self.imageReco.topPrediction)
        Image(systemName: "plus.square.on.square")
            .onTapGesture {
                self.showImagePicker = true
            }
        }
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(selectedImage: $selectedImage)
        })
        .onChange(of: self.selectedImage, perform: { value in
            imageReco.makePrediction(image: self.selectedImage){
                self.connection.switchCharacteristic(characteristic: "FA083A03-B3DD-4529-880B-FF430B85E410", callback:{
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { t in
                        connection.sendData(message: self.imageReco.topPrediction)
                        print("sent \(self.imageReco.topPrediction)")
                    }
                })
            }
        })
    }
}

#Preview {
    ImageRecoView()
}
