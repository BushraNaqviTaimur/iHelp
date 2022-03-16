//
//  OnboardingView.swift
//  iHelp
//
//  Created by Bushra on 11/12/21.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: -PROPERTIES
    
    
    //MARK: -BODY
    var body: some View {
        TabView{
        splashscreenview()
        }.tabViewStyle(PageTabViewStyle()) //modifier
            .padding(.vertical ,20)
    }
}

//MARK: -PREVIEW

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
