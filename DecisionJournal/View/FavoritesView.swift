//
//  FavoritesView.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/17/24.
//

import SwiftData
import SwiftUI

struct FavoritesView: View {
    @Namespace private var namespace
    @Query private var decisions: [Decision]
    var body: some View {
        NavigationStack {
            List {
                ForEach(decisions.filter(\.isFavorite)) { decision in
                    NavigationLink(value: decision) {
                        Text(decision.title)
                            .matchedTransitionSource(id: decision.id, in: namespace)
                    }
                }
            }
            .navigationDestination(for: Decision.self) { decision in
                Text(decision.detail)
                    .navigationTransition(.zoom(sourceID: decision.id, in: namespace))
            }
        }
    }
}

#Preview(traits: .previewData) {
    FavoritesView()
}
