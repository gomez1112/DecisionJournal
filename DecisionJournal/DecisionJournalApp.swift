//
//  DecisionJournalApp.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import AppIntents
import SwiftUI
import SwiftData

@main
struct DecisionJournalApp: App {
    private var metrics: MetricsManager
    private var model: DataModel
    private var container: ModelContainer
    
    init() {
        container = ModelContainer.createContainer
        let dataModel = DataModel(container: container)
        let metricsModel = MetricsManager()
        model = dataModel
        metrics = metricsModel
        
        AppDependencyManager.shared.add(dependency: dataModel)
        AppDependencyManager.shared.add(dependency: metricsModel)
    }
    var body: some Scene {
        WindowGroup {
            DestinationTabs()
        }
        .environment(metrics)
        .environment(model)
        .modelContainer(ModelContainer.createContainer)
    }
}
