//
//  Color+Extension.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import SwiftUI
import UIKit

extension Color {
    var toRGBA: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
      //  #if os(iOS)
        let uiColor = UIColor(self)
//        #else
//        let uiColor = NSColor(self)
//        #endif
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (red, green, blue, alpha)
        }
        return nil
    }
}

