//
//  ContentView.swift
//  Assignment7_Mapkit
//
//  Created by Willie Green on 10/11/23.
//

import MapKit
import SwiftUI
import UserNotifications

struct StoreLocation: Identifiable {
    let id = UUID()
    let storeName: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42, longitude: -110),span: MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 12.0))
    
    let storeLocation = [
        StoreLocation(storeName: "evo Seatle", coordinate: CLLocationCoordinate2D(latitude: 47.649590, longitude: -122.342250)),
        StoreLocation(storeName: "evo Portland", coordinate: CLLocationCoordinate2D(latitude: 45.521230, longitude: -122.661420)),
        StoreLocation(storeName: "evo Denver", coordinate: CLLocationCoordinate2D(latitude: 39.7303, longitude: -104.9871)),
        StoreLocation(storeName: "evo Whistler", coordinate: CLLocationCoordinate2D(latitude: 50.116300, longitude: -122.955190)),
        StoreLocation(storeName: "evo Salt Lake", coordinate: CLLocationCoordinate2D(latitude: 40.754980, longitude: -111.902650)),
        StoreLocation(storeName: "evo Snoqualmie Pass", coordinate: CLLocationCoordinate2D(latitude: 47.420640, longitude: -121.411750)),
        StoreLocation(storeName: "evo Hood River", coordinate: CLLocationCoordinate2D(latitude: 45.521230, longitude: -122.661420)),
        StoreLocation(storeName: "evo Tahoe City", coordinate: CLLocationCoordinate2D(latitude: 39.170350, longitude: -120.142190)),
        StoreLocation(storeName: "rythm Japan", coordinate: CLLocationCoordinate2D(latitude: 48.114790, longitude: -123.560230)),
    ]
    
    @State var storeLocationPicker = "Seatle"
    let storeLocationOptions:[String] = [
        "Seatle", "Portland", "Denver", "Whistler", "Salt Lake", "Snoqualmie Pass", "Hood River", "Tahoe City", "Japan"]
    
    var body: some View {
        VStack{
            
            Button("Request Authorization"){
                UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .badge, .sound]){success, error in
                    if success{
                        print("all set")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }}
            }
            Map(coordinateRegion: $mapRegion, annotationItems: storeLocation){ location in
                MapAnnotation(coordinate: location.coordinate){
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 5)
                            Image ("evoLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30)
                                .padding(5)
                        }
                        Text(location.storeName)
                        
                    }
                }
                
            }
            .mapStyle(.hybrid(elevation: .realistic))
            Button("Schedule Notification"){
                let content = UNMutableNotificationContent()
                content.title = "Reservation Reminder"
                content.subtitle = "Time to pick up your rental!"
                content.sound = UNNotificationSound.default
                
                let triger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
