//
//  Color+Ext.swift
//  Momentum
//
//  Created by Aman Gupta on 28/06/25.
//

import Foundation
import SwiftUI


public extension Color{
    static func random(randomOpacity: Bool = false)-> Color{
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}
