//
//  iHelpApp.swift
//  iHelp
//
//  Created by Bushra on 11/12/21.
//

import SwiftUI
import Firebase

@main
struct iHelpApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    //appdelegateadaptor is our app delegate here and its gonna be withhold into appDelegate instance
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
    }
    

