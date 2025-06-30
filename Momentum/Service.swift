//
//  Service.swift
//  Momentum
//
//  Created by Aman Gupta on 30/06/25.
//

import Foundation

struct Service: Identifiable,Codable{
    var id = UUID()
    var name: String
    var icon: String
    var isPopular: Bool?

}


var services = [
    Service(name:"Netflix",icon:"", isPopular: true),
    Service(name:"Youtube Premium",icon:"", isPopular: true),
    Service(name:"Amazon Prime",icon:"", isPopular: true),
    Service(name:"Spotfiy",icon:"",  isPopular: true),
    Service(name:"Spotify",icon:"", isPopular: true),
    Service(name:"Disney +",icon:"", isPopular: true),
    Service(name:"Apple Music",icon:"", isPopular: true),
    Service(name:"HBO Max",icon:"", isPopular: true),
    Service(name:"Prime Video",icon:"", isPopular: true),
    Service(name:"Hulu",icon:"", isPopular: true),
    Service(name:"iCloud +",icon:"", isPopular: true),
    Service(name:"Google One",icon:"", isPopular: true),
    Service(name:"Youtube Music",icon:"", isPopular: true),
    Service(name:"Google One",icon:"", isPopular: true),
    Service(name:"Linkedin Premium",icon:"", isPopular: true)
    
    
]
