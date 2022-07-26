//
//  DistressSignal.swift
//  iHelp
//
//  Created by Bushra on 11/27/21.
//

import SwiftUI



struct DistressSignal: View {
   
    var body: some View {
       
        ZStack{
                VStack{

                    
                
           
                    
                }//end of vstack1
                   
             
                   
            
     //end of zstack
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .accentColor(Color.black)
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]), startPoint: .leading, endPoint: .trailing))
                
        
    }
}


struct mainScreen_Previews: PreviewProvider {
    static var previews: some View {
        DistressSignal()
    }
}
