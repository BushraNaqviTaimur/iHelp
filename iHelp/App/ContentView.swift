//
//  ContentView.swift
//  iHelp
//
//  Created by Bushra on 11/12/21.
//

import SwiftUI

struct ShadowButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .shadow(
        color: configuration.isPressed ? Color.blue : Color.black,
        radius: 4, x: 0, y: 5
      )
  }
}


struct ContentView: View {
   // @State private var isShowingSettings: Bool = false
    
    @EnvironmentObject var viewModel: AppViewModel
     
    var body: some View {
        
        NavigationView{
            if viewModel.signedIn{
        
        ZStack{
                VStack{
               
                        
                    
                        Spacer()
                        Button( action: {},
                                label:
                                    {
                            NavigationLink(destination: DistressSignal())
                            {
                            Text("Help Me")
                                .fontWeight(.bold)
                                .font(.title)
                                .padding()
                                .background(Color.red)
                            
                                .cornerRadius(70)
                                .foregroundColor(.white)
                                .padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.purple, lineWidth: 5))
                            }
                        })
                    
                    Spacer()
                    
                    
                   /* Button( action: {},
                            label:
                                {
                        NavigationLink(destination: MapView())
                        {Text("Map View")
                            .fontWeight(.bold)
                            .font(.title)
                            .padding()
                            .background(Color.white)
                        
                            .cornerRadius(70)
                            .foregroundColor(.purple)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.purple, lineWidth: 5))
                        }
                    })
                    
                    
                            
                            
                    Button(action:{
                        viewModel.signOut()
                        
                    }, label: {
                        Text("Sign Out")
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .padding()
                    }) */
                     
                        //Spacer()
                     
                }//end of vstack1
          
                .navigationBarItems(trailing:
                                        
                                Button(action:{
                                    viewModel.signOut()
                                    
                                }, label: {
                                    Text("Sign Out")
                                        .padding()
                                        //.background(Color.purple)
                                        .foregroundColor(.blue)
                                        .padding()
                                        //.border(Color.purple, width: 5)
                                        
                                        .frame(width: 200, height: 100, alignment: .topTrailing)
                                        //.background(Color.green)
                                        //.foregroundColor(Color.white)
                                       
                                })
                                    //.buttonStyle(ShadowButtonStyle())
                                
            )//nav trailing
            
            
     //end of zstack
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .accentColor(Color.black)
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .leading, endPoint: .trailing))
            }
            else {
            
            LoginView()
            }
            }//end of nav
        
        
            .onAppear {

            viewModel.signedIn=viewModel.isSignedIn
            }
           
       
}
}

                                
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppViewModel())
    }
}



