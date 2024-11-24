//
//  Metrics.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import Foundation
import SwiftData

@Model
final class Metrics {
    var totalDecisions: Int = 0
    var totalReflections: Int = 0
    var averageReflectionRating: Double = 0.0
    var successRate: Double = 0.0
    var averageDecisionToReflectionTime: TimeInterval = 0.0
    var pendingReflections: Int = 0
    var averageConfidenceScore: Double = 0.0
    var priorityDistribution: [Decision.Priority: Int] = [:] // [Priority Level: Count]
    var categoryCounts: [String: Int] = [:]    // [Category: Count]
    var tagFrequency: [String: Int] = [:]      // [Tag: Count]
    
    init(totalDecisions: Int, totalReflections: Int, averageReflectionRating: Double, successRate: Double, averageDecisionToReflectionTime: TimeInterval, pendingReflections: Int, averageConfidenceScore: Double, priorityDistribution: [Decision.Priority : Int], categoryCounts: [String : Int], tagFrequency: [String : Int]) {
        self.totalDecisions = totalDecisions
        self.totalReflections = totalReflections
        self.averageReflectionRating = averageReflectionRating
        self.successRate = successRate
        self.averageDecisionToReflectionTime = averageDecisionToReflectionTime
        self.pendingReflections = pendingReflections
        self.averageConfidenceScore = averageConfidenceScore
        self.priorityDistribution = priorityDistribution
        self.categoryCounts = categoryCounts
        self.tagFrequency = tagFrequency
    }
    
    @MainActor static let sampleMetrics = Metrics(
        totalDecisions: 50,
        totalReflections: 40,
        averageReflectionRating: 4.2,
        successRate: 0.85, // 85% success rate
        averageDecisionToReflectionTime: 86400.0, // 1 day in seconds
        pendingReflections: 10,
        averageConfidenceScore: 7.5,
        priorityDistribution: [
            .medium: 15,  // 15 decisions with priority 1
            .high: 20,  // 20 decisions with priority 2
            .low: 15   // 15 decisions with priority 3
        ],
        categoryCounts: [
            "Administrative": 20,
            "Technology": 10,
            "Professional Development": 15,
            "Operations": 5
        ],
        tagFrequency: [
            "training": 12,
            "policy": 8,
            "technology": 10,
            "budget": 5
        ]
    )
}

