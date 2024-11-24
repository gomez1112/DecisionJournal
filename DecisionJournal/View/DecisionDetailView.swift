//
//  DecisionDetailView.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import SwiftUI

struct DecisionDetailView: View {
    let decision: Decision
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Text("Description")
                    .font(.headline)
                Text(decision.detail)
                    .font(.body)
                    .foregroundStyle(.secondary)
                Divider()
                Text("Expected Outcomes")
                    .font(.headline)
                Text(decision.expectedOutcomes)
                    .font(.body)
                    .foregroundStyle(.secondary)
                Text("Expected Shortcomings")
                    .font(.headline)
                Text(decision.expectedShortcomings)
                    .font(.body)
                    .foregroundStyle(.secondary)
                if let reflections = decision.reflections {
                    Divider()
                    Text("Reflections")
                        .font(.title2)
                    ForEach(reflections) { reflection in
                        ReflectionCardView(reflection: reflection)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(decision.title)
    }
}

#Preview {
    NavigationStack {
        DecisionDetailView(decision: Decision.sampleDecisions.first!)
    }
}
