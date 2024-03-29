//
//  ContentView.swift
//  VentureBookAppClip
//
//  Group 4
//  Michael Kempe, 991 566 501
//  Kevin Tran, 991 566 232
//  Anh Phan, 991 489 221
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
    
    @State private var selection : Int? = nil
    
    @State private var selectedNote : Note? = nil
    
    @State private var pings : [MyPings] = [MyPings(coordinate: CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude), title: "Example!", holding:
                                                        Note(title: "Example!", desc: "A taste of how the real app works", trip: "", picture: UIImage(named: "placeholder")!.pngData()!, location: "Sheridan College")
                                                   )];
    
    var body: some View {
        NavigationView{
            ZStack{
                NavigationLink(destination: NoteDetails(note: selectedNote), tag: 1, selection: $selection){} //Link to navigate to the details page
                Map(coordinateRegion: $region, showsUserLocation: true,  userTrackingMode: .constant(.follow),
                annotationItems: pings){item in
                    //Custom map annotation
                    MapAnnotation(coordinate: item.coordinate)
                    {
                        ZStack {
                            Color.white.ignoresSafeArea()
                            VStack {
                                Image(uiImage: UIImage(data: item.holding.picture) ?? UIImage(named: "placeholder")!)
                                    .resizable()
                                    .frame(width: 60, height: 60, alignment: .leading)
                                Text(item.title).fontWeight(.bold).font(.system(size: 10)).padding(3)
                            }
                        }
                        .onTapGesture {
                            print("Tapped")
                            self.selection = 1
                            self.selectedNote = item.holding
                        }
                    }
                }
                .frame(width: 400, height: 300)
            }.navigationBarTitle("Map View", displayMode: .inline).navigationBarItems(trailing: Image(systemName: "map.fill"))

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
