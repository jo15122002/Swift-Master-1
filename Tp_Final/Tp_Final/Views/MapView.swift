//
//  MapView.swift
//  Tp_Final
//
//  Created by digital on 21/11/2023.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var annotations: [MapAnnotationItem]

    func makeUIView(context: Context) -> MKMapView {
        return MKMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateAnnotations(for: uiView)
    }

    private func updateAnnotations(for mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        
        let newAnnotations = annotations.map { item -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = item.coordinate
            annotation.title = item.title
            return annotation
        }
        
        mapView.addAnnotations(newAnnotations)
        if let firstAnnotation = newAnnotations.first {
            mapView.setCenter(firstAnnotation.coordinate, animated: true)
        }
    }
}


#Preview {
    MapView(annotations: [])
}

struct MapAnnotationItem {
    let coordinate: CLLocationCoordinate2D
    let title: String?
}
