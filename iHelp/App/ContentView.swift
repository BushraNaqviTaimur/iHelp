//
//  ContentView.swift
//  iHelp
//
//  Created by Bushra on 11/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingSettings: Bool = false
        
    
    var body: some View {
          
        NavigationView{
            LoginView()
            //mainScreen()
            
            
            
        .navigationTitle("iHelp")
            .navigationBarItems(trailing:
                                Button(action: {
                isShowingSettings = true })
                                {
                Image(systemName: "slider.horizontal.3") //thatslider icon to open settings view
            } //button
             .sheet(isPresented: $isShowingSettings){
              SideMenuView()
    }
                                )
        }
}
}
                                
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
