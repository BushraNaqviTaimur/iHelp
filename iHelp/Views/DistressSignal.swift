//
//  DistressSignal.swift
//  iHelp
//
//  Created by Bushra on 11/27/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import CoreLocation

//the purpose of this:
//1. fetch users from database
//2. identify nearby
//3. send push notification with your lat and long to nearby

struct DistressSignal: View {
    
    @StateObject private var viewModel = DistressSignalModel()

   
    var body: some View {
        
        
       
        ZStack{
                VStack{

                    
                    Button(action:{
                        viewModel.fetchNearByUsersFromDB()
                        

                        
                        
                    }, label: {
                        Text("test action")
                            .frame(width: 200, height: 50)
                            .background(Color.purple)
                            .foregroundColor(Color.white)
                            .padding()
                    })
                    
                   
           
                    
                }//end of vstack1
        
     //end of zstack
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .accentColor(Color.black)
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .leading, endPoint: .trailing))
                
        
    }
}

class DistressSignalModel: ObservableObject {
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userID = Auth.auth().currentUser
    
    @Published var myLat:Double!
    @Published var myLon:Double!
    
    //@Published var results:String!
    
    
    
    @Published var user = [Users] ()
    
    func fetchNearByUsersFromDB() {
        
    db.collection("Locations").addSnapshotListener { (querySnapshot, error) in
       guard let documents = querySnapshot?.documents else {
           print ("No document")
           return
       }
        
        //quering first loop to determine current signed in user's location
       self.user = documents.map {(queryDocumentSnapshot) -> Users in
           let data = queryDocumentSnapshot.data()
           
           //fetching each user location
           let UiD = data["UserID"]as? String ?? ""
           let Latitude = data["Latitude"]as? Double ?? 0.0
           let Longitude = data["Longitude"]as? Double ?? 0.0
           
           //saving current user location
           if UiD == self.userID?.uid
           {
               self.myLat=Latitude
               self.myLon=Longitude
           }
           
     
           //self.user.append(data)
           
           return Users(Latitude : Latitude, Longitude: Longitude)
       }
        
        //initializing results
        //self.results="Nearby users within 50KM"
        
        //quering second loop for distance comparison between signed in user's location and
        // all other nearby users within 50KM
        self.user = documents.map {(queryDocumentSnapshot) -> Users in
            let data = queryDocumentSnapshot.data()
            
            //fetching each user location
            let UiD = data["UserID"]as? String ?? ""
            let Latitude = data["Latitude"]as? Double ?? 0.0
            let Longitude = data["Longitude"]as? Double ?? 0.0
            
            
            // this check is placed so that current signed in user's location and ID is left out
            // for neaby comparison
            if UiD != self.userID?.uid
            {
                
            
            
            //creating 2 coordinates for distance comparison
            let coordinate0 = CLLocation(latitude: self.myLat, longitude: self.myLon)
            let coordinate1 = CLLocation(latitude: Latitude, longitude: Longitude)

            let distanceInMeters = coordinate0.distance(from: coordinate1)
            
            if(distanceInMeters <= 50000) //50000 because in 1 KM there are 1000 meters so in 50 KM there will be 50,000 meters
             {
             // under 50 KM
                //print(UiD)
                print(UiD)
                
             }
             else
            {
             // out of 1 KM
             }
                
                
                
            }
            
            
            //self.user.append(data)
            
            return Users(Latitude : Latitude, Longitude: Longitude)
        }
        
       }
    }
    
    
}


struct mainScreen_Previews: PreviewProvider {
    static var previews: some View {
        DistressSignal()
    }
}
