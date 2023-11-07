//
//  DataDownloader.swift
//  SwiftUI_CoreML
//
//  Created by digital on 07/11/2023.
//

import Foundation

class DataDownloader : ObservableObject {
    @Published var data:Data?
    
    func downloadDataAtUrl(urlString:String) -> Bool{
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let e = error {
                    print("Foutu")
                }
                
                if let res = response,
                   let data = data{
                    DispatchQueue.main.async{
                        self.data = data
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
