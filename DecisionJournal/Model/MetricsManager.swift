//
//  MetricsManager.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import Foundation
import Observation

@MainActor
@Observable
final class MetricsManager {
    
    // Total Decisions Made
    func totalDecisions(decisions: [Decision]) -> Int {
        decisions.count
    }
    
    // Total Reflections Added
    func totalReflections(reflections: [Reflection]) -> Int {
        reflections.count
    }
    
    // Average Reflection Rating
    func averageReflectionRating(reflections: [Reflection]) -> Double {
        let ratings = reflections.map { Double($0.rating) }
        return ratings.isEmpty ? 0.0 : ratings.reduce(0, +) / Double(ratings.count)
    }
    
    // Success Rate
    func successRate(decisions: [Decision]) -> Double {
        let successfulDecisions = decisions.filter { $0.isSuccessful }.count
        return decisions.isEmpty ? 0.0 : (Double(successfulDecisions) / Double(decisions.count)) * 100
    }
    
    // Average Time Between Decision and Reflection
    func averageDecisionToReflectionTime(reflections: [Reflection]) -> TimeInterval {
        let intervals = reflections.compactMap { reflection -> TimeInterval? in
            guard let decisionDate = reflection.decision?.date else { return nil }
            return reflection.reflectionDate.timeIntervalSince(decisionDate)
        }
        return intervals.isEmpty ? 0.0 : intervals.reduce(0, +) / Double(intervals.count)
    }
    
    // Number of Pending Reflections
    func pendingReflections(decisions: [Decision]) -> Int {
        decisions.filter { ($0.reflections?.isEmpty ?? true) }.count
    }
    
    // Average Confidence Score
    func averageConfidenceScore(decisions: [Decision]) ->  Double {
        let scores = decisions.map { Double($0.confidenceScore) }
        return scores.isEmpty ? 0.0 : scores.reduce(0, +) / Double(scores.count)
    }
    
    func priorityDistribution(decisions: [Decision]) -> [Decision.Priority: Int] {
        decisions.reduce(into: [:]) { $0[$1.priority, default: 0] += 1 }
    }
    
    func categoryCounts(decisions: [Decision]) -> [Category: Int] {
        decisions.reduce(into: [:]) { $0[$1.category ?? Category.sampleCategories.first!, default: 0] += 1 }
    }
    
    // Tag Frequency
    func tagFrequency(decisions: [Decision]) -> [String: Int] {
        decisions.reduce(into: [:]) { frequency, decision in
            for tag in decision.tags {
                let normalizedTag = tag.lowercased()
                frequency[normalizedTag, default: 0] += 1
            }
        }
    }
}

