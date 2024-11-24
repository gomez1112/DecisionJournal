//
//  AllDecisionsView.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/17/24.
//

import SwiftData
import SwiftUI

struct AllDecisionsView: View {
    @Query private var categories: [Category]
    @Namespace private var namespace
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    Section(category.title) {
                        ForEach(category.decisions ?? []) { decision in
                            NavigationLink(value: decision) {
                                DecisionCardView(decision: decision)
                                    .matchedTransitionSource(id: decision.id, in: namespace)
                            }
                        }
                    }
                }
                #if !os(watchOS)
                .listRowSeparator(.hidden)
                #endif
            }
            .listStyle(.plain)
            .navigationDestination(for: Decision.self) { decision in
                DecisionDetailView(decision: decision)
                    .navigationTransition(.zoom(sourceID: decision.id, in: namespace))
            }
            .navigationTitle("Decisions")
        }
    }
}

#Preview(traits: .previewData) {
    AllDecisionsView()
}
