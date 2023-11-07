//
//  ImageRecognition.swift
//  SwiftUI_CoreML
//
//  Created by digital on 07/11/2023.
//

import Foundation
import UIKit

class ImageRecognition : ObservableObject {
    private var imagePredictor:ImagePredictor = ImagePredictor();
    
    @Published var topPrediction:String = "";
    
    func makePrediction(image:UIImage){
        try? self.imagePredictor.makePredictions(for: image) { predictions in
            if let firstPred = predictions?.first{
                self.topPrediction = firstPred.classification
            }
        }
    }
}
