//
//  ReflectionCardView.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import SwiftUI

struct ReflectionCardView: View {
    let maxRating = 5
    let reflection: Reflection
    var body: some View {
        VStack(alignment: .leading) {
            Text(reflection.reflectionDate, style: .date)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("Actual Outcomes")
                .font(.headline)
            Text(reflection.actualOutcomes)
                .font(.body)
            Text("Actual Shortcomings")
                .font(.headline)
            Text(reflection.actualShortcomings)
                .font(.body)
            if !reflection.keyLearnings.isEmpty {
                Text("Key Learnings")
                    .font(.headline)
                Text(reflection.keyLearnings)
                    .font(.body)
            }
            if !reflection.improvementIdeas.isEmpty {
                Text("Improvement Ideas")
                    .font(.headline)
                Text(reflection.improvementIdeas)
                    .font(.body)
            }
            HStack {
                Text("Rating:")
                ForEach(1...maxRating, id: \.self) { index in
                    Image(systemName: index <= reflection.rating ? "star.fill" : "star")
                        .foregroundColor(index <= reflection.rating ? .yellow : .gray)
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 2)
    }
}

#Preview {
    ReflectionCardView(reflection: .sampleReflections.first!)
}
