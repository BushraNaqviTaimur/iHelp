//
//  MainView.swift
//  iHelp
//
//  Created by Bushra on 7/29/22.
//

import SwiftUI

struct MainView: View {
    //@State private var selection = "LoginView"
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
         //Text("fdc")
        
        
        NavigationView{
            
            if viewModel.signedIn{
                
        ZStack{
        
           
        
        VStack{ //v2
        TabView (){
            ContentView()
           .tabItem{
                    Image(systemName: "house")
                   .foregroundColor(Color(.systemPurple))
                    Text("Home")
                   
                }
            MapView()
                .tabItem{
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(Color(.systemPurple))
                    Text("MapView")
                        
        }
            ProfileView()
                .tabItem{
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color(.systemPurple))
                    Text("Profile")
                       
                }
                
}//end of tabview
        
        //.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }//end of vstack2
        
        }
                
            }else {
                
                LoginView()
            }

        
        }.onAppear {
        
        viewModel.signedIn=viewModel.isSignedIn
        }
    
}
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
