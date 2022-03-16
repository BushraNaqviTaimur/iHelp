//
//  SideMenuView.swift
//  iHelp
//
//  Created by Bushra on 1/6/22.
//

import SwiftUI

struct SideMenuView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack //(alignment: .leading)
                {
                    HStack {
                        
                        Button(action: {
                           //action
                        }) {
                        Image(systemName: "person")
                                //.foregroundColor(.black)
                                .imageScale(.large)
                        
                        Text("Profile")
                                //.foregroundColor(.gray)
                                .font(.headline)
                        }.padding()
                    }
                        HStack {
                            Button(action: {
                               //action
                            }) {
                                Image(systemName: "gear")
                                    //.foregroundColor(.gray)
                                    .imageScale(.large)
                                Text("Settings")
                                   // .foregroundColor(.gray)
                                    .font(.headline)
                            }.padding()
                        }
                            HStack {
                                Button(action: {
                                   //action
                                }) {
                                Image(systemName: "person.fill.questionmark")
                                    //.foregroundColor(.gray)
                                    .imageScale(.large)
                                Text("FAQ")
                                    //.foregroundColor(.gray)
                                    .font(.headline)
                            }
                            
                                .padding()
                            }
                Spacer()
                    
                }//end of vstack
                
                
                .navigationBarTitle(Text("iHelp"), displayMode: .large )
            
            .navigationBarItems(
                trailing:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        Image(systemName: "xmark")
                    }
                )
            .padding()
            
            }//end of scrollview
            
        }//end of navigation view
       
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}


