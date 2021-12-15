//
//  ContentView.swift
//  VentureBookAppClip
//
//  Created by Michael Kempe on 2021-12-13.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    //variables to store navigation information
    
    private enum MapDefaults {
        static let latitude = 43.46909205277883
        static let longitude = -79.69961738210894
        static let zoom = 0.5
    }
    
    @State private var pings : [MyPings] = [MyPings(coordinate: CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude), title: "Example!", holding: Note())];
    
    var body: some View {
        ZStack{
            //Color.backgroundColor.edgesIgnoringSafeArea(.all)
            Map(coordinateRegion: $region, showsUserLocation: true,  userTrackingMode: .constant(.follow),
            annotationItems: pings){item in
                //Custom map annotation
                MapAnnotation(coordinate: item.coordinate)
                {
                    ZStack {
                        Color.white.ignoresSafeArea()
                        Text(item.title).fontWeight(.bold).padding(3)
                    }
                }
            }
            .frame(width: 400, height: 300)
        }.navigationBarTitle("Map View", displayMode: .inline).navigationBarItems(trailing: Image(systemName: "map.fill"))

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Note {}
