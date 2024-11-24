//
//  PreviewData.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import Foundation
import SwiftData
import SwiftUI

struct PreviewData: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        let schema = Schema([Category.self , Reflection.self , Decision.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: configuration)
        let categories = Category.sampleCategories
        let reflections = Reflection.sampleReflections
        let decisions = Decision.sampleDecisions
        
        
        categories.forEach { container.mainContext.insert($0)}
        reflections.forEach { container.mainContext.insert($0)}
        decisions.forEach { container.mainContext.insert($0)}
        
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .environment(MetricsManager())
            .environment(DataModel(container: context))
            .modelContainer(context)
    }
}

