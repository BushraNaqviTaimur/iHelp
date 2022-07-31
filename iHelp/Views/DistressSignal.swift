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
import MessageUI

//the purpose of this:
//1. fetch users from database
//2. identify nearby
//3. send push notification with your lat and long to nearby

struct DistressSignal: View {

    @State private var isShowingMessages = false
    
    @ObservedObject var viewModel = DistressSignalModel()

    
    var body: some View {
         
        ZStack{
                VStack{
                    
                    Text("Distress signal...")
                        .onAppear(){
                        do {
                    viewModel.getNearByUsersNumbersAndCurrentUserLocationForSMS()
                           }
                        
                        self.isShowingMessages = true

                                    }
                          
                         .sheet(isPresented: self.$isShowingMessages) {
                                
                             //this if check ensures that message view only appears
                             //once database gives back the values for both required
                             //numbers and composed message
                             if(viewModel.FormattedNumbersToMessage.count != 0)
                             {
                                
                                 MessageComposeView(recipients: viewModel.FormattedNumbersToMessage, body: viewModel.SMSToMessage) { messageSent in
                                     print("MessageComposeView with message sent? \(messageSent)")
                                                        }
                             }
                                                       }
                 
                } //end of vstack1
        
     //end of zstack
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .accentColor(Color.black)
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .leading, endPoint: .trailing))
                
    }
}

class DistressSignalModel: ObservableObject {
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    let db2 = Firestore.firestore()
    var userID = Auth.auth().currentUser
    
    var myLat:Double=0.0
    var myLon:Double=0.0
    
    @Published var FormattedNumbersToMessage = [String]()
    @Published var SMSToMessage = ""
    var NearestUserIDs:[String?] = []
    var AllUserIDs:[String] = []
    
    @Published var user = [Users] ()
    @Published var user2 = [Users] ()
    
    var flagvar = true
 
    func getNearByUsersNumbersAndCurrentUserLocationForSMS() {
        
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
           
           
           //creating SMS message to send with Google Maps location URL of current signed in user
           
           let StrLat = String(describing: self.myLat)
           let StrLon = String(describing: self.myLon)
           
           self.SMSToMessage = "Message from iHelp: Please help me at http://maps.google.com/maps?q="+StrLat+","+StrLon
           
           return Users(Latitude : Latitude, Longitude: Longitude)
       }
        
        
        //quering second loop for distance comparison between signed in user's location and
        // all other nearby users within 50KM
        self.user = documents.map {(queryDocumentSnapshot) -> Users in
            let data = queryDocumentSnapshot.data()
            
            //fetching each user
            let UiD = data["UserID"]as? String ?? ""
            let Latitude = data["Latitude"]as? Double ?? 0.0
            let Longitude = data["Longitude"]as? Double ?? 0.0
            
            
            // this check is placed so that current signed in user's location and ID is left out for neaby comparison
            if UiD != self.userID?.uid
            {
        
            //creating 2 coordinates for distance comparison
            let coordinate0 = CLLocation(latitude: self.myLat, longitude: self.myLon)
            let coordinate1 = CLLocation(latitude: Latitude, longitude: Longitude)

            let distanceInMeters = coordinate0.distance(from: coordinate1)
            
            if(distanceInMeters <= 50000) //50000 because in 1 KM there are 1000 meters so in 50 KM there will be 50,000 meters
             {
             // under 50 KM
                
                self.NearestUserIDs.append(UiD)
                
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
        
        var x=0
        
        //quering this time for fetching phone numbers of nearby Users which we found above
        db2.collection("Users").addSnapshotListener { (querySnapshot, error) in
           guard let documents = querySnapshot?.documents else {
               print ("No document")
               return
           }
  
            
            //getting all User IDs from Users collection > Users document
            for document in querySnapshot!.documents {

               //print(document.documentID)
                self.AllUserIDs.append(document.documentID)
                 
                   }
            
            self.user2 = documents.map {(queryDocumentSnapshot) -> Users in
               let data = queryDocumentSnapshot.data()
                                
                  //getting trustedcontact for logged in user
                for document in querySnapshot!.documents {

                    if(self.flagvar)
                    {
                        if self.userID?.uid == document.documentID
                        {
                            let trustedNumber = document.get("TrustedContact")as! Int64
                            let trustedNumberinString = String(trustedNumber)
                            self.FormattedNumbersToMessage.append(trustedNumberinString)
                            
                            //adding police number
                            let policeNumberinString = "3048447749" //bushra's number acts as police number for testing
                            self.FormattedNumbersToMessage.append(policeNumberinString)
                            
                            self.flagvar=false
                        }
                    }
                         
                           }
                
                //check for nearby users only
                if self.NearestUserIDs.contains(self.AllUserIDs[x])
                {
                    //fetching phone numbers from nearby users
                     let phoneNumber = data["Phone"]as! Int64
                     let phoneNumberinString = String(phoneNumber)
                     self.FormattedNumbersToMessage.append(phoneNumberinString)
                     
                }
                x+=1
                            
                
                return Users(Latitude : 0.0, Longitude: 0.0)

           }
            
            
            
        }
        
    
        
        //resetting the variables for next time
        self.FormattedNumbersToMessage.removeAll()
        self.AllUserIDs.removeAll()
        self.NearestUserIDs.removeAll()
        self.flagvar=true

    }
    

    
}


struct mainScreen_Previews: PreviewProvider {
    static var previews: some View {
        DistressSignal()
    }
}

//code required for SMS compose window inside app
struct MessageComposeView: UIViewControllerRepresentable {
    typealias Completion = (_ messageSent: Bool) -> Void

    static var canSendText: Bool { MFMessageComposeViewController.canSendText() }
        
    let recipients: [String]?
    let body: String?
    let completion: Completion?
    
    func makeUIViewController(context: Context) -> UIViewController {
        guard Self.canSendText else {
            let errorView = MessagesUnavailableView()
            return UIHostingController(rootView: errorView)
        }
        
        let controller = MFMessageComposeViewController()
        controller.messageComposeDelegate = context.coordinator
        controller.recipients = recipients
        controller.body = body
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completion: self.completion)
    }
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        private let completion: Completion?

        public init(completion: Completion?) {
            self.completion = completion
        }
        
        public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true, completion: nil)
            completion?(result == .sent)
        }
    }
}

struct MessagesUnavailableView: View {
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .font(.system(size: 64))
                .foregroundColor(.red)
            Text("Messages is unavailable")
                .font(.system(size: 24))
        }
    }
}
