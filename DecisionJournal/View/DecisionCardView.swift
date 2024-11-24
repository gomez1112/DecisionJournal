//
//  DecisionCardView.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import SwiftData
import SwiftUI

struct DecisionCardView: View {
    @Environment(\.modelContext) private var context
    let decision: Decision
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(decision.title)
                .font(.headline)
            Text(decision.detail)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            HStack {
                Text("Priority: \(decision.priority.rawValue.capitalized)")
                    .font(.caption)
                Spacer()
                Text(decision.date, style: .date)
                    .font(.caption)
            }
        }
        .padding()
        .background(decision.color)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 2)
    }
}

#Preview() {
    DecisionCardView(decision: .sampleDecisions.first!)
}
