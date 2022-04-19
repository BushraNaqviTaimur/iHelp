//
//  ContentView.swift
//  iHelp
//
//  Created by Bushra on 11/12/21.
//

import SwiftUI



struct ContentView: View {
    @State private var isShowingSettings: Bool = false
    
    @EnvironmentObject var viewModel: AppViewModel
    

     
    var body: some View {
          
        NavigationView{
            if viewModel.signedIn{
            VStack{
        Text ("Welcome to iHelp")
                    .padding()
                    .padding()
                NavigationLink("Help Me!", destination: mainScreen())
                VStack{
                    
                    NavigationLink("Map View", destination: MapView())
                }
                
                Button(action:{
                    viewModel.fetchAndSaveLocation()
                    
                }, label: {
                    Text("Save Current Location")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .padding()
                })
                
                .padding()
                
                Button(action:{
                    viewModel.signOut()
                    
                }, label: {
                    Text("Log out")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .padding()
                })
                
                
                
            }
                
        }
        else {
           
        LoginView()
        }
        }
        .onAppear {

        viewModel.signedIn=viewModel.isSignedIn
        }
}
}
                                
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
