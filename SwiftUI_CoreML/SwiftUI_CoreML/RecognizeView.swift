//
//  NewView.swift
//  test
//
//  Created by Al on 07/11/2023.
//

import SwiftUI
import UIKit

struct RecognizeView: View {
    // État pour le tableau des couleurs
    @State private var colors: [Color] = [.red, .green, .blue, .orange, .yellow, .purple, .pink]
    
    @State var urlString = ""
    @State var dataUrlString = ""
    @State var urlList = ["https://cataas.com/cat", "https://picsum.photos/200/300"]
    
    @ObservedObject var downloader:ImageDownloader = ImageDownloader()
    @ObservedObject var dataDownloader:DataDownloader = DataDownloader()
    
    @ObservedObject var imageRecognition = ImageRecognition()
    
    var body: some View {
        VStack {
            List(urlList, id: \.self) { element in
                Text(element).onTapGesture {
                    self.downloadImageAtUrlString(urlString: element)
                }
            }
            
            
            TextField("URL:", text: $urlString).onSubmit {
                print("Enter clicked")
                print(urlString)
                self.urlList.append(urlString)
                //self.downloadImageAtUrlString(urlString: urlString)
            }
            // Image centrée horizontalement
            Image(uiImage: downloader.image ?? UIImage()) // Remplacez par le nom de votre image dans les Assets
                .resizable() // Pour permettre à l'image de changer de taille
                .scaledToFit() // Pour s'assurer que l'image soit à l'échelle
                .frame(width: 200, height: 200) // La taille désirée de l'image
                .padding() // Pour ajouter un peu d'espace autour de l'image
                .onChange(of: downloader.image, perform: { value in
                    if let image = value{
                        self.imageRecognition.makePrediction(image: image)
                    }
                })
            Text(self.imageRecognition.topPrediction)
                
            // Titre sous l'image
            Text("Votre Titre")
                .font(.title)
                .padding([.top, .bottom], 10) // Ajoute de l'espace au-dessus et en dessous du titre
            
            // Bouton pour ajouter une nouvelle couleur
            Button(action: {
                // Ajouter une nouvelle couleur de manière aléatoire
                self.colors.append(Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)))
                
            }) {
                Text("Ajouter une couleur")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            // Vue permettant le scroll horizontal de différents carrés de couleurs
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(colors, id: \.self) { color in
                        Rectangle()
                            .fill(color)
                            .frame(width: 100, height: 100) // La taille de chaque carré de couleur
                    }
                }
                .padding(.horizontal) // Ajoute de l'espace sur les côtés dans la ScrollView
            }
            
            VStack{
                TextField("URL:", text: $dataUrlString).onSubmit {
                    print("Enter clicked")
                    print(dataUrlString)
                    if (!dataDownloader.downloadDataAtUrl(urlString: dataUrlString)){
                        print("show popup")
                    }
                }
                //Text("\(dataDownloader.data?.count)")
            }
        }
    }
    
    func downloadImageAtUrlString(urlString:String){
        if !downloader.downloadImageAtUrl(urlString: urlString){
            print("show popup")
        }
    }
}


#Preview {
    RecognizeView()
}
