//
//  splashscreenview.swift
//  iHelp
//
//  Created by Bushra on 11/12/21.
//

import SwiftUI


struct splashscreenview: View {
    
    //MARK -PROPERTIES

    @State private var isAnimating: Bool = false
    //since this is not any bool value that can be modified, we will use @state
    //@state property wrapper will allow us to mutate the state of the animation everytime the card appears on the screen
    //by default the value is false, meaning image is still

    
    var body: some View {
        
        VStack(spacing: 20) {
        // TITLE
        Text("iHelp")
            .foregroundColor(Color.black)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .shadow(color: Color(red: 0, green: 0, blue: 0,opacity: 0.15), radius: 2,x: 2, y: 2 )
            .scaleEffect(isAnimating ? 1.0 : 0.6) //everytime screen loads, screen will first shrink to 0.1 then
                                                   //"ease out" to 0.6
        }.onAppear{ //adding animation
            withAnimation(.easeOut(duration: 0.5)) {  //ANIMATION TYPE IS EASEOUT AND HALF A SECOND LONG
                isAnimating = true
    }
}
    }

struct splashscreenview_Previews: PreviewProvider {
    static var previews: some View {
        splashscreenview()
            .previewLayout(.fixed(width: 320, height: 640))
    }
}
    }
