//
//  CodableColor.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import SwiftUI

struct CodableColor: Codable {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double
    
    init(color: Color) {
        if let components = color.toRGBA {
            self.red = Double(components.red)
            self.green = Double(components.green)
            self.blue = Double(components.blue)
            self.alpha = Double(components.alpha)
        } else {
            self.red = 0
            self.green = 0
            self.blue = 0
            self.alpha = 1
        }
    }
    
    var toColor: Color {
        Color(
            red: red,
            green: green,
            blue: blue,
            opacity: alpha
        )
    }
}

