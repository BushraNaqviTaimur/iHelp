//
//  mainScreen.swift
//  iHelp
//
//  Created by Bushra on 11/27/21.
//

import SwiftUI



struct mainScreen: View {
   
    var body: some View {
       
        ZStack{
                VStack{
                Spacer()

                    
                        Spacer()
                        Button( action: {},
                                label:
                                    {
                            Text("Help")
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
                            
                        })
                    
                        Spacer()
                
           
                    
                }//end of vstack1
                   
             
                   
            
     //end of zstack
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .accentColor(Color.black)
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .leading, endPoint: .trailing))
                
        
    }
}


struct mainScreen_Previews: PreviewProvider {
    static var previews: some View {
        mainScreen()
    }
}
