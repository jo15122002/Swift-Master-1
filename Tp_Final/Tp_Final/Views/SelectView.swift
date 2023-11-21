//
//  TabView.swift
//  Tp_Final
//
//  Created by digital on 21/11/2023.
//

import SwiftUI

struct SelectView: View {
    var body: some View {
        TabView {
            GraphView()
                    .tabItem {
                        Label("Graph", systemImage: "chart.xyaxis.line")
                    }
                
            MapView()
                .tabItem {
                    Label("Carte", systemImage: "map")
                }
                
            ImageRecoView()
                .tabItem {
                    Label("Reco images", systemImage: "photo.artframe")
                }
            }
        }
    }

#Preview {
    SelectView()
}
