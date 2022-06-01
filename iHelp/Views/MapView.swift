//
//  MapView.swift
//  iHelp
//
//  Created by Bushra on 4/10/22.
//
import MapKit
import SwiftUI
import Firebase
import FirebaseFirestore

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()

    
  
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true )
            .ignoresSafeArea()
            .accentColor(Color(.systemPurple))
            .onAppear {
                viewModel.checkifLocatinServicesIsEnabled()
              //  viewModel.fetchData()
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
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userID = Auth.auth().currentUser
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0,longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    //this changes so ui will be updated
    
    var LocationManager: CLLocationManager?
    var location: CLLocation?
    
    func checkifLocatinServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() { //CHECKING APP AUTHORIZATION
            LocationManager = CLLocationManager() //we created location manager which then goes down to checks auth with func checklocationauth.
        
            
            LocationManager!.delegate = self
            //LocationManager?.desiredAccuracy = kCLLocationAccuracyBest
            
        } else {
            LocationManager?.requestAlwaysAuthorization()
            
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
        case .authorizedAlways:
            region = MKCoordinateRegion(center: LocationManager.location!.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
           LocationManager.allowsBackgroundLocationUpdates =  true
           ///
       //LocationManager.startUpdatingLocation()
   LocationManager.startMonitoringSignificantLocationChanges()
           ///
           fetchAndSaveLocationInDB()
           fetchData()
       case .authorizedWhenInUse:
           region = MKCoordinateRegion(center: LocationManager.location!.coordinate,
                                       span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
          //LocationManager.allowsBackgroundLocationUpdates =  false
          LocationManager.allowsBackgroundLocationUpdates =  true
          //LocationManager.stopUpdatingLocation()
          LocationManager.startMonitoringSignificantLocationChanges()
          fetchAndSaveLocationInDB()
           fetchData()
        @unknown default:
            break
        }
        
    }
    

    
    //delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
         checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            location = locations.first
            region = MKCoordinateRegion(center: manager.location!.coordinate,
                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            fetchAndSaveLocationInDB()
            //LocationManager.stopUpdatingLocation()
        }
    
        
    
    
    func fetchAndSaveLocationInDB() {
        
        CLLocationManager().requestAlwaysAuthorization()
        
        let uuid: String = Auth.auth().currentUser!.uid ?? ""
        let lat: Double = CLLocationManager().location?.coordinate.latitude ?? 0.0
        let lon: Double = CLLocationManager().location?.coordinate.longitude ?? 0.0
        
        Auth.auth().addStateDidChangeListener { (auth, userID) in
          if (userID != nil) {
              self.db.collection("Locations").document(userID!.uid).setData([
              "UserID": uuid,
              "Latitude": lat,
              "Longitude": lon
              ])
          }
        }
        
        
    }
    
    func UpdateLocationInDB(lat: Double, lon: Double) {
        
        Auth.auth().addStateDidChangeListener { (auth, userID) in
          if (userID != nil) {
              self.db.collection("Locations").document(userID!.uid).setData([
              "Latitude": lat,
              "Longitude": lon
              ])
          }
        }
        
        
    }
    
    
    ///
    @Published var user = [Users] ()
    
    
  //let db2 = Firestore.firestore()
    
    
    func fetchData() {
        db.collection("Locations").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print ("No document")
                return
            }
            
            self.user = documents.map {(queryDocumentSnapshot) -> Users in
                let data = queryDocumentSnapshot.data()
                
              
                let UiD = data["UserID"]as? String ?? ""
                let Latitude = data["Latitude"]as? Double ?? 0.0
                let Longitude = data["Longitude"]as? Double ?? 0.0
                
                
                
                
                //self.user.append(data)
                
                return Users(Latitude : Latitude, Longitude: Longitude)
            }
                 
            }
            
            
            
            
        }
    
}

