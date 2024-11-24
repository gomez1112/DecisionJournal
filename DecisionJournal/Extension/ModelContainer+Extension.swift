//
//  ModelContainer+Extension.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import Foundation
import SwiftData


extension ModelContainer {
    static let createContainer: ModelContainer = {
        let schema = Schema([Category.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Could not create model container: \(error.localizedDescription).")
        }
    }()
}

