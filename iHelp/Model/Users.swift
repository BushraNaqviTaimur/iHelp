//
//  Users.swift
//  iHelp
//
//  Created by Bushra on 5/30/22.
//

import Foundation

struct Users: Identifiable {
    
    var id: String = UUID().uuidString
    var Latitude: Double
    var Longitude: Double
}
