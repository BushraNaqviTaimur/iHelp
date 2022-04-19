//
//  MapView.swift
//  iHelp
//
//  Created by Bushra on 4/10/22.
//
import MapKit
import SwiftUI

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
  
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true )
            .ignoresSafeArea()
            .accentColor(Color(.systemPurple))
            .onAppear {
                viewModel.checkifLocatinServicesIsEnabled()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

//added delegate now bcox we want to listen if user changes locarion permission status
final class MapViewModel: NSObject ,ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 24.891752,longitude: 67.102087), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    //this changes so ui will be updated
    
    var LocationManager: CLLocationManager?
    
    func checkifLocatinServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() { //CHECKING APP AUTHORIZATION
            LocationManager = CLLocationManager() //we created location manager which then goes down to checks auth with func checklocationauth.
            LocationManager!.delegate = self
            //LocationManager?.desiredAccuracy = kCLLocationAccuracyBest
            
        } else {
            print ("Turn on Locations in settings")
            
        }
        }
    
   private  func checkLocationAuthorization() {
        guard let LocationManager = LocationManager else { return } //unwrap locationmanager object
 
        switch LocationManager.authorizationStatus {
            
            
        case .notDetermined: //means now allowed by phone so give popup
            LocationManager.requestAlwaysAuthorization()
        case .restricted:
            print ("Your location is restricted likely due to parental controls.")
        case .denied:
            print ("You have denied location sharing. Go to settings and turn on location services.")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: LocationManager.location!.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        @unknown default:
            break
        }
        
    }
    //delegate method
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
         checkLocationAuthorization()
    }
}

