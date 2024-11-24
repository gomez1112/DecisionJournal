//
//  Binding+Extension.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/17/24.
//

import Foundation
import SwiftUI

extension Binding where Value == Date? {
    func withDeafultValue(_ defaultValue: Date = .now) -> Binding<Date> {
        Binding<Date>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0 }
        )
    }
}
