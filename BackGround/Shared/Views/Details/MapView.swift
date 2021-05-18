//
//  MapView.swift
//  BackGround
//
//  Created by Matt Goodrich on 5/16/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region: MKCoordinateRegion
    
    init(lat: Double, lon: Double) {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(lat: 34.011_286, lon: -116.166_868)
    }
}
