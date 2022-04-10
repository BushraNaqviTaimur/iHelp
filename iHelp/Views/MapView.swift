//
//  MapView.swift
//  iHelp
//
//  Created by Bushra on 4/10/22.
//
import MapKit
import SwiftUI

struct MapView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 24.891752,longitude: 67.102087), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    
    var body: some View {
        Map(coordinateRegion: $region)
            .ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
