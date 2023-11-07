//
//  Downloader.swift
//  SwiftUI_CoreML
//
//  Created by digital on 07/11/2023.
//

import Foundation
import UIKit

class Downloader : ObservableObject {
    //@Published var image:UIImage? = UIImage(named: "maison")
    @Published var image:UIImage?
    
    func downloadImageAtUrl(urlString:String) -> Bool{
        
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let e = error {
                    print("Foutu")
                }
                
                if let res = response,
                   let data = data,
                   let image = UIImage(data: data){
                    DispatchQueue.main.async{
                        self.image = image
                    }
                }else{
                    print("Foutu 2")
                }
            }
            
            task.resume()
            return true
        }else{
            return false
        }
    
    }
}
