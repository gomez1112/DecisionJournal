//
//  Tabs.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/17/24.
//

import Foundation
import SwiftUI

enum Tabs: Equatable, Hashable, Identifiable, CaseIterable {
    case dashboard
    case allDecisions
    case favorites
    case analytics
    case settings
    
    var id: Self { self }
    
    var title: String {
        switch self {
            case .dashboard: "Dashboard"
            case .allDecisions: "All Decisions"
            case .favorites: "Favorites"
            case .analytics: "Analytics"
            case .settings: "Settings"
        }
    }
    
    var customizationID: String {
        "com.transfinite.decisionjournal.\(id)"
    }
    
    var symbol: String {
        switch self {
            case .dashboard: "house"
            case .allDecisions: "list.bullet"
            case .favorites: "star"
            case .analytics: "chart.bar"
            case .settings: "gearshape"
        }
    }
    
    @MainActor @ViewBuilder
    func destination() -> some View {
        switch self {
            case .dashboard: DashboardView()
            case .allDecisions: AllDecisionsView()
            case .favorites: FavoritesView()
            case .analytics: AnalyticsView()
            case .settings: SettingsView()
        }
    }
}
