//
//  DestinationTabs.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/17/24.
//

import SwiftUI
import SwiftData

struct DestinationTabs: View {
    @Environment(\.modelContext) private var context
    @State private var selectedTab: Tabs = .dashboard
    #if !os(watchOS)
    @AppStorage("SidebarCustomizations") private var tabViewCustomization: TabViewCustomization
    #endif
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tabs.allCases) { tab in
                Tab(tab.title, systemImage: tab.symbol, value: tab) {
                    tab.destination()
                }
                .customizationID(tab.customizationID)
            }
        }
        #if !os(watchOS)
        .tabViewSidebarFooter {
            Button("Add Data") {
                let category = Category(title: "New Category")
                context.insert(category)
                let decision = Decision(title: "New Decision", color: .green, category: category)
                context.insert(decision)
                
            }
        }
        .tabViewSidebarHeader {
            Text("Decision Journal")
                .font(.largeTitle)
        }
        .tabViewStyle(.sidebarAdaptable)
        .tabViewCustomization($tabViewCustomization)
        #endif
    }
}

#Preview(traits: .previewData) {
    DestinationTabs()
}
